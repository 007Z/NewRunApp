//
//  RunBpushInfo.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunBpushInfo.h"

@implementation RunBpushInfo

-(id)init
{
    if (self == [super init]) {
        self.app_id = @"";
        self.channel_id = @"";
        self.request_id = @"";
        self.user_id = @"";
    }
    return self;
}


+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"app_id":@"app_id",
             @"channel_id":@"channel_id",
             @"request_id":@"request_id",
             @"user_id":@"user_id"
             };
}

@end
