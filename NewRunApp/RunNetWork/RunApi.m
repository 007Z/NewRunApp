//
//  RunApi.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunApi.h"

@implementation RunApi

NSString *const BaseURL = @"http://115.28.213.41:8080/MayiRunning/";

NSString *const RegisterUrl  = @"APP_UserRegister!UserRegister.action";

NSString *const LoginUrl = @"APP_UserLogin!UserLogin.action";

NSString *const StartOrderUrl = @"APP_UserOrder!UserOrder.action";

NSString *const AddAddressUrl = @"APP_UserAddAddress!UserAddAddress.action";

NSString *const GetAllAddressUrl = @"APP_UserGetAllAddress!UserGetAllAddress.action";

NSString *const RemindOrderUrl = @"APP_UserReminder!UserReminder.action";

NSString *const WorkerLocatUrl = @"APP_UserGetWorkerLocation!UserGetWorkerLocation.action";

NSString *const CancelOrderUrl = @"APP_UserCancelOrder!UserCancelOrder.action";

NSString *const UpdateUseDataUrl = @"APP_UserUpdatePersonInfo!UserUpdatePersonInfo.action";

NSString *const DeleAddressUrl = @"APP_UserDeleteAddress!UserDeleteAddress.action";

NSString *const ReSetPwdUrl = @"APP_ResetPassword!ResetPassword.action";

NSString *const UserCheckOrdState = @"APP_UserCheckOrderState!UserCheckOrderState.action";



@end
