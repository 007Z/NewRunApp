//
//  RegisterView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextField.h"


@interface RunRegisterView : UIView
//手机号
@property(nonatomic,strong)RunCustomTextField  *phoneTextField;
//验证码
@property(nonatomic,strong)RunCustomTextField  *verCodeTextField;
//密码
@property(nonatomic,strong)RunCustomTextField  *pwdTextField;
//获取验证码按钮
@property(nonatomic,strong)UIButton  *verCodeBtn;
//完成按钮
@property(nonatomic,strong)UIButton  *finishBtn;
//协议
@property(nonatomic,strong)UIButton  *agreeMentBtn;

@property(nonatomic,copy)NSString  *msg;

//协议视图隐藏
-(void)setBottomViewHide;
//键盘小时
-(void)setKeyBoardHide;
@end
