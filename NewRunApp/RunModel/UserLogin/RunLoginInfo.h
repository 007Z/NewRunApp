//
//  RunLoginInfo.h
//  NewRunApp
//
//  Created by ZHAO on 22/9/15.
//  Copyright (c) 2015年 赵玖录. All rights reserved.
//

#import "RunBaseModel.h"


@interface RunLoginInfo : RunBaseModel
@property (nonatomic,copy)NSString  *UserPwd;//密码
@property(nonatomic,copy)NSString   *UserTel;//用户手机
@property(nonatomic,copy)NSString   *UserNilkName;//用户昵称
@property(nonatomic,copy)NSString   *UserToken;//用户token值
@property(nonatomic,copy)NSString   *UserId;//用户id
@property(nonatomic,copy)NSString   *UserHeadUrl;//用户头像

@end
