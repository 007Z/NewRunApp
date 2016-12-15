//
//  AppDelegate.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)BMKMapManager  *mapManager;

@property (strong, nonatomic) UIWindow *window;


@end

