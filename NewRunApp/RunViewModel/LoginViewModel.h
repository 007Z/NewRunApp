//
//  LoginViewModel.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject
//手机号
@property(nonatomic,copy)NSString  *phoneStr;
//验证码
@property(nonatomic,copy)NSString  *verCodeStr;
//密码
@property(nonatomic,copy)NSString  *pwdStr;

/**请求登录*/
-(void)RunLoginWithView:(UIView *)view withFinishBlock:(void(^)(BOOL))finishBlock;

@end
