//
//  GolbalManager.m
//  TuBuyEat
//  Created by 耿用强 on 14-3-26.
//  Copyright (c) 2014年 耿用强. All rights reserved.

#import "GolbalManager.h"
@implementation GolbalManager
static GolbalManager *shareManager=nil;

#pragma mark - 获取单例
+ (GolbalManager*)sharedManager{
    if (!shareManager) {
        @synchronized(self)
        {
            
            if (!shareManager)
            {
                shareManager = [[GolbalManager alloc]init];
            }
        }
    }
    return shareManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    if (shareManager == nil)
    {
        @synchronized(self)
        {
            if (shareManager == nil)
            {
                shareManager = [super allocWithZone:zone];
            }
        }
    }
    return shareManager;
}

- (id)init
{
    if (self = [super init])
    {
        [shareManager initsub];
    }
    return self;
}
-(void)initsub
{

}
-(void)dealloc
{
   
}

@end
