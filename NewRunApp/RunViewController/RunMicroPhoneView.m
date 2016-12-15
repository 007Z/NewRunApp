//  RunvoiceView.m
//  Runapp
//  Created by 赵玖录 on 15/8/31.
//  Copyright (c) 2015年 gyq. All rights reserved.

#import "RunMicroPhoneView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "lame.h"

#define WAVE_UPDATE_FREQUENCY   1

@interface RunMicroPhoneView ()<AVAudioRecorderDelegate>
{
    NSTimer  *timer_;
}
@property(nonatomic,strong)AVAudioRecorder  *RunRecorder;
@property(nonatomic,strong)AVAudioSession * audioSession;

@end
@implementation RunMicroPhoneView
@synthesize recordTime;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"voice"];
        [self initSubViews];
        [self audio];
    }
    return self;
}

-(void)initSubViews
{
    _RunTimeLab = [[UILabel alloc] init];
    _RunTimeLab.textAlignment = NSTextAlignmentCenter;
    _RunTimeLab.textColor = [UIColor whiteColor];
    _RunTimeLab.font = FONT_(13);
    _RunTimeLab.text = @"00:00";
    [self addSubview:_RunTimeLab];
}

-(void)layoutSubviews
{
    _RunTimeLab.frame = CGRectMake(0,self.height-RESIZE_UI(40),self.width,RESIZE_UI(20));
}

- (void)audio
{
    self.recordCafPath = [NSTemporaryDirectory() stringByAppendingString:RecorderCAFFile];
    self.recordMp3Path = [NSTemporaryDirectory() stringByAppendingString:RecorderMp3File];
    
    self.recordUrl = [NSURL URLWithString:[NSTemporaryDirectory() stringByAppendingString:RecorderCAFFile]];
    NSError *error;
    //初始化

    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    _RunRecorder = [[AVAudioRecorder alloc]initWithURL:self.recordUrl settings:recordSettings error:&error];
    //开启音量检测
    _RunRecorder.meteringEnabled = YES;
    _RunRecorder.delegate = self;
    

}

-(void)dealloc
{
    if (_RunRecorder.isRecording) {
        [_RunRecorder stop];
    }
    _RunRecorder = nil;
}

-(void)runStartRecorder
{
    _audioSession = [AVAudioSession sharedInstance];
    if (![_RunRecorder isRecording]){
        [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];//设置类别,表示该应用同时支持播放和录音
        [_audioSession setActive:YES error:nil];//启动音频会话管理,此时会阻断后台音乐的播放.
        [_RunRecorder prepareToRecord];
        [_RunRecorder peakPowerForChannel:0.0];
        [_RunRecorder record];
        recordTime = 0;
        timer_ = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
}

-(void)updateTimer
{
    [_RunRecorder updateMeters];
    recordTime +=WAVE_UPDATE_FREQUENCY;
    if (recordTime == 30) {
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [timer_ invalidate];
        [_RunTimeLab setText:@"00:00"];
    }else{
        int minute = recordTime/60.0;
        int second = recordTime-minute*60;
        [_RunTimeLab setText:[NSString stringWithFormat:@"%02d:%02d",minute,second]];
    }
}

-(void)runCancelRecorder
{
    [_RunRecorder stop];
    [_audioSession setActive:NO error:nil];
    [timer_ invalidate];
    //caf转mp3
    if ([RunComment isRecorderFileExistwithStrPath:self.recordCafPath]) {
        [self audio_PCMtoMP3:self.recordCafPath andMP3FilePath:self.recordMp3Path];
    }
    [_RunTimeLab setText:@"00:00"];
}

-(void)removeCoderVoice
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.recordCafPath error:nil];
    [fileManager removeItemAtPath:self.recordMp3Path error:nil];
    
    NSLog(@"删除当前录音");
}

- (void)audio_PCMtoMP3:(NSString *)cafFilePath andMP3FilePath:(NSString *)mp3FilePath
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil]) {
        NSLog(@"删除");
    }
    
    @try {
        NSInteger read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        
        if(pcm == NULL) {
            NSLog(@"file not found");
        } else {
            fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
            
            const int PCM_SIZE = 8192;
            const int MP3_SIZE = 8192;
            short int pcm_buffer[PCM_SIZE*2];
            unsigned char mp3_buffer[MP3_SIZE];
            
            lame_t lame = lame_init();
            lame_set_in_samplerate(lame, 11025.0);
            lame_set_VBR(lame, vbr_default);
            lame_init_params(lame);
            
            do {
                read = fread(pcm_buffer, 2 * sizeof(short int), PCM_SIZE, pcm);
                if (read == 0)
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                else
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                
                fwrite(mp3_buffer, write, 1, mp3);
                
            } while (read != 0);
            
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"MP3生成成功");
    }
}

-(void)showMicroPhone
{
    self.hidden = NO;
}

-(void)hideMicroPhone
{
    self.hidden = YES;
}

@end
