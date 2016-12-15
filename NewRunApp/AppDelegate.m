//
//  AppDelegate.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "AppDelegate.h"
#import "RunNavViewController.h"
#import "RunMainViewController.h"

//短信验证
#import <SMSSDK.h>
//百度推送
#import "BPush.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = [[RunNavViewController alloc] initWithRootViewController:[[RunMainViewController alloc] init]];
    [RunNavViewController shareNavgationController].fullScreenPopGestureEnable = YES;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 50.0f;
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BmapKey generalDelegate:nil];
    if (!ret){
    }
    //判断登录状态
    [self makeloginState];
    
    //注册短信验证
    [SMSSDK registerApp:AppKey withSecret:AppSecret];
    
    //注册百度云推送
    [self baiduPushWithLanchOptication:launchOptions];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 判断登陆状态
-(void)makeloginState
{
    NSString*islogin=[[NSUserDefaults standardUserDefaults]objectForKey:ISLOGIN];
    if ([islogin isEqualToString:@"yes"]) {
        [GolbalManager sharedManager].isLogin=YES;
        NSDictionary*data=[RunComment getLoginPlist:LoginFile];
        [GolbalManager sharedManager].loginInfo=(RunLoginInfo *)[MTLJSONAdapter modelOfClass:[RunLoginInfo class] fromJSONDictionary:data error:nil];
    }else
    {
        [GolbalManager sharedManager].isLogin=YES;
    }
//    NSString *isorder = [[NSUserDefaults standardUserDefaults] objectForKey:ISORDER];
//    if ([isorder isEqualToString:@"yes"]) {
//        [GolbalManager sharedManager].isOrder = YES;
//        NSDictionary *data = [Commend getLoginPlist:OrderFile];
//        [GolbalManager sharedManager].orderInfo = [RunOrderInfo runOrderInfoWithDic:data];
//    }
}

#pragma  注册百度推送
-(void)baiduPushWithLanchOptication:(NSDictionary *)lanch
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    [BPush registerChannel:lanch apiKey:PushKey pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];
    //app从点击推送消息启动
    NSDictionary *userInfo = [lanch objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
}

/** 应用在前台,或者开启后台并且应用在后台是调用*/
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHNOTIFICATION" object:nil userInfo:userInfo];
}

/**在iOS8系统中，还需要添加这个方法。通过新的 API 注册推送服务*/
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

/** 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败*/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        if (result) {
            
            [GolbalManager sharedManager].pushinfo = (RunBpushInfo *)[MTLJSONAdapter modelOfClass:[RunBpushInfo class] fromJSONDictionary:result error:nil];
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];
}

/** 当 DeviceToken 获取失败时，系统会回调此方法*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
    }
}

#pragma --mark 接受本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgtask;
    bgtask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgtask != UIBackgroundTaskInvalid) {
                bgtask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgtask != UIBackgroundTaskInvalid) {
                bgtask = UIBackgroundTaskInvalid;
            }
        });
    });
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    double delayInSecond = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
    dispatch_after(popTime,dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnterForeground" object:nil];
    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
