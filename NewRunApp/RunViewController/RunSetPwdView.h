//
//  RunSetPwdView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextField.h"

@interface RunSetPwdView : UIView
//旧密码
@property(nonatomic,strong)RunCustomTextField  *oldPwdTextField;
//新密码
@property(nonatomic,strong)RunCustomTextField  *newstPwdTextField;
//确认密码
@property(nonatomic,strong)RunCustomTextField  *conFirmPwdTextField;
//获取验证码按钮
@property(nonatomic,strong)UIButton  *finishBtn;

-(void)setKeyBoardHide;
@end
