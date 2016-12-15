//
//  RunVoiceOrderView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/17.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunVoiceOrderView : UIView

@property(nonatomic,strong)UIButton  *addressBtn;
//下单
@property(nonatomic,strong)UIButton  *orderBtn;

//录音地址
@property(nonatomic,strong)NSString  *recorderPath;
//时长
@property(nonatomic)int allTime;

-(void)RunStarPLayRecoderWithUrl:(NSURL *)recodeUrl;

//显示
-(void)show;
//隐藏
-(void)hide;
//添加到父视图
-(void)showInView:(UIView *)view;

@end
