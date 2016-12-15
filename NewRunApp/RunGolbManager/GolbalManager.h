//  GolbalManager.h
//  TuBuyEat
//  Created by 耿用强 on 14-3-26.
//  Copyright (c) 2014年 耿用强. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RunLoginInfo.h"
#import "RunBpushInfo.h"

@interface GolbalManager : NSObject
//是否登录
@property (nonatomic,assign)BOOL isLogin;
//登录信息
@property(nonatomic,strong)RunLoginInfo  *loginInfo;
//推送信息
@property(nonatomic,strong)RunBpushInfo  *pushinfo;

@property(nonatomic)CLLocationCoordinate2D  Coordinate;

+ (GolbalManager*)sharedManager;
@end
