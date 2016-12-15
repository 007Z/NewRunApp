//
//  RunVoiceOrderView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/17.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunVoiceOrderView.h"
#import <AVFoundation/AVFoundation.h>

@interface RunVoiceOrderView ()
{
    NSTimer* timer;
    int playDuration;
    int playTime;
    UIImageView *_voiceBackImg;
    UIImageView *_line;
    UIImageView *_bottomLine;
    UIImageView *_wordOrImg;
    UIImageView *_arrowImg;
    UILabel     *_sendAddressLab;
    
    CGRect originFrame;
}

//阴影部分
@property(nonatomic,strong)UIImageView *headerView;

//地址
@property(nonatomic,strong)UILabel  *addressLab;
@property(nonatomic,strong)UIButton *shadowBtn;
//播放
@property(nonatomic,strong)UIButton *playBtn;
//取消
@property(nonatomic,strong)UIButton *cancelBtn;
//播放进度显示标签
@property(nonatomic,strong)UILabel *progressLab;
@property (retain, nonatomic) AVAudioPlayer *runAvPlay;

@end

@implementation RunVoiceOrderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        originFrame = frame;
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    _headerView = [[UIImageView alloc] init];
    _headerView.backgroundColor = RGBColor(244, 244, 244, 1);
    [self addSubview:_headerView];
    
    _voiceBackImg = [[UIImageView alloc] init];
    _voiceBackImg.image = [UIImage imageNamed:@"voice_butt"];
    [_headerView addSubview:_voiceBackImg];
    
    _playBtn = [UIButton createBtnWithnorImage:@"video_ico" selectedImage:@"video_ico" target:self action:@selector(playAction)];
    [_headerView addSubview:_playBtn];
    
    _progressLab = [[UILabel alloc] init];
    _progressLab.textColor = RGBColor(101, 88, 8, 1);
    _progressLab.textAlignment = NSTextAlignmentCenter;
    _progressLab.font = FONT_(16);
    _progressLab.text = @"00:00";
    [_headerView addSubview:_progressLab];
    
    _cancelBtn = [UIButton createBtnWithnorImage:@"video_colose" selectedImage:@"video_colose" target:self action:@selector(cancelAction)];
    [_headerView addSubview:_cancelBtn];

    _line = [[UIImageView alloc] init];
    _line.backgroundColor = RGBColor(170, 170, 170, 1);
    [self addSubview:_line];
    
    _wordOrImg = [[UIImageView alloc] init];
    _wordOrImg.image = [UIImage imageNamed:@"video_single"];
    [self addSubview:_wordOrImg];
    
    _sendAddressLab = [[UILabel alloc] init];
    _sendAddressLab.textColor = RGBColor(240, 83, 10, 1);
    _sendAddressLab.font = FONT_(14);
    _sendAddressLab.text = @"送达地址:";
    [self addSubview:_sendAddressLab];
    
    _addressLab = [[UILabel alloc] init];
    _addressLab.textColor = RGBColor(147, 148, 149, 1);
    _addressLab.font = FONT_(14);
    _addressLab.text = @"请选择详细地址";
    [self addSubview:_addressLab];
    
    _arrowImg = [[UIImageView alloc] init];
    _arrowImg.image = [UIImage imageNamed:@"single_open_ico"];
    [self addSubview:_arrowImg];
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_addressBtn];
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = RGBColor(170, 170, 170, 1);
    [self addSubview:_bottomLine];
    
    _orderBtn = [UIButton createBtnWithnorBGImage:@"single_butt" selectedBGImage:@"single_butt" target:self action:nil];
    [_orderBtn setTitle:@"下单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_orderBtn];
    
    _shadowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shadowBtn.alpha = 0;
    _shadowBtn.hidden = YES;
    _shadowBtn.backgroundColor = [UIColor clearColor];
    [_shadowBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerView.frame = CGRectMake(0, 0, self.width,RESIZE_UI(100));
    
    _voiceBackImg.frame = CGRectMake(RESIZE_UI(23),(_headerView.height-RESIZE_UI(60))/2,_headerView.width-RESIZE_UI(46),RESIZE_UI(60));
    _progressLab.frame = CGRectMake((_headerView.width-RESIZE_UI(200))/2,(_headerView.height-13)/2,RESIZE_UI(200),13);
    _playBtn.frame = CGRectMake(RESIZE_UI(30),(_headerView.height-RESIZE_UI(45))/2,RESIZE_UI(45), RESIZE_UI(45));
    _cancelBtn.frame = CGRectMake(_headerView.width-RESIZE_UI(30)-RESIZE_UI(45),_playBtn.top,RESIZE_UI(45),RESIZE_UI(45));
    _line.frame = CGRectMake(0,_headerView.bottom,self.width,0.5);
    
    _wordOrImg.frame = CGRectMake(RESIZE_UI(23),_line.bottom+10,RESIZE_UI(40),RESIZE_UI(40));
    
    _sendAddressLab.frame = CGRectMake(_wordOrImg.right+5,_wordOrImg.top+_wordOrImg.height/2-13/2,67,13);
    _addressLab.frame = CGRectMake(_sendAddressLab.right+10,_sendAddressLab.top,self.width-_sendAddressLab.right-10-RESIZE_UI(23)-10,13);
    _arrowImg.frame = CGRectMake(self.width-RESIZE_UI(13)-RESIZE_UI(23),_addressLab.top+_addressLab.height/2-RESIZE_UI(21/2),RESIZE_UI(13),RESIZE_UI(21));
    
    _addressBtn.frame = CGRectMake(_wordOrImg.right,_wordOrImg.top,self.width-_wordOrImg.right-RESIZE_UI(23),RESIZE_UI(40));
    
    _bottomLine.frame = CGRectMake(_wordOrImg.left,_wordOrImg.bottom+10,self.width-RESIZE_UI(23),0.5);
    
    _orderBtn.frame = CGRectMake((self.width-RESIZE_UI(86))/2,_bottomLine.bottom+30,RESIZE_UI(86), RESIZE_UI(86));
}

//显示
-(void)show
{
    self.shadowBtn.alpha = 1;
    self.shadowBtn.hidden = NO;
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        
        CGRect frame = self.frame;
        frame.origin.y -= self.height;
        self.frame = frame;
        self.shadowBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    } completion:^(BOOL finished) {
        
        @strongify(self);
        [self setRecordTime:self.allTime];
    }];
}

//隐藏
-(void)hide
{
    self.shadowBtn.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.shadowBtn.backgroundColor = [UIColor clearColor];
        self.shadowBtn.hidden = YES;
        self.frame = originFrame;
    }];
}

-(void)showInView:(UIView *)view
{
    _shadowBtn.frame = CGRectMake(0, 0,CGRectGetWidth(view.bounds),CGRectGetHeight(view.bounds));
    [view addSubview:_shadowBtn];
    [view addSubview:self];
}

//播放
-(void)playAction
{
    
}

//取消
-(void)cancelAction
{
    
}

-(void)RunStarPLayRecoderWithUrl:(NSURL *)recodeUrl
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    _runAvPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:recodeUrl error:nil];
    _runAvPlay.volume = 1;
    playDuration = (int)_runAvPlay.duration;
    playTime = 0;
}

-(void)setRecordTime:(int)totalTime
{
    int minute = totalTime/60.0;
    int second = totalTime-minute*60;
    [_progressLab setText:[NSString stringWithFormat:@"%02d:%02d",minute,second]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
