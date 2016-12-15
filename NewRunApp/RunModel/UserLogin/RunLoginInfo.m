//  RunLoginInfo.m
//  NewRunApp
//  Created by ZHAO on 22/9/15.
//  Copyright (c) 2015年 赵玖录. All rights reserved.

#import "RunLoginInfo.h"

@implementation RunLoginInfo

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"UserPwd":@"UserPwd",
             @"UserTel":@"UserTel",
             @"UserNilkName":@"UserNilkName",
             @"UserToken":@"UserToken",
             @"UserId":@"UserId",
             @"UserHeadUrl":@"UserHeadUrl"
             };
}

@end
