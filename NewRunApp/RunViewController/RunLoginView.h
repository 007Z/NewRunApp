//
//  RunLoginView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextField.h"

@interface RunLoginView : UIView

//手机号
@property(nonatomic,strong)RunCustomTextField  *phoneTextField;
//密码
@property(nonatomic,strong)RunCustomTextField  *pwdTextField;
//忘记密码
@property(nonatomic,strong)UIButton  *forgetPwdBtn;
//完成
@property(nonatomic,strong)UIButton  *finishBtn;
//协议
@property(nonatomic,strong)UIButton  *agreementBtn;
//注册
@property(nonatomic,strong)UIButton  *registerBtn;

-(void)setKeyBoardHide;

@end
