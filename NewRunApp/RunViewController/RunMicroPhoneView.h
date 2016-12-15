//  RunvoiceView.h
//  Runapp
//  Created by 赵玖录 on 15/8/31.
//  Copyright (c) 2015年 gyq. All rights reserved.

#import <UIKit/UIKit.h>

@interface RunMicroPhoneView : UIImageView

//显示时间
@property(nonatomic,strong)UILabel   *RunTimeLab;
@property(nonatomic,strong)NSURL  *recordUrl;
/**caf路径*/
@property(nonatomic,strong)NSString *recordCafPath;
/**mp3路径*/
@property(nonatomic,strong)NSString *recordMp3Path;
@property(nonatomic)int recordTime;

-(void)runStartRecorder;
-(void)runCancelRecorder;
-(void)removeCoderVoice;

-(void)showMicroPhone;
-(void)hideMicroPhone;
@end
