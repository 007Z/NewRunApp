//
//  RunComment.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunComment.h"
#import "MBProgressHUD.h"
#import "ASProgressText.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RunComment

+ (void)showAlert:(NSString*)alertString
{
    if (alertString.length > 0) {
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[ASProgressText class]]) {
                return;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ASProgressText*textView = [[ASProgressText alloc]initWithMessgae:alertString withView:nil];
            [textView showAnimation];
            [textView hide:2.0];
        });
    }
}

+ (void)showAlert:(NSString*)alertString withImgString:(NSString *)imgStr
{
    if (alertString.length > 0) {
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[ASProgressText class]]) {
                return;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ASProgressText*textView = [[ASProgressText alloc]initWithMessgae:alertString withImage:[UIImage imageNamed:imgStr] withView:nil];
            [textView showAnimation];
            [textView hide:2.0];
        });
    }
}

+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+(void)writeLoginPlist:(NSDictionary*)aDic string:(NSString*)str//通用存储plist文件
{
    NSDictionary * array = [[NSDictionary alloc] initWithDictionary:aDic];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:str];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:filename contents:nil attributes:nil];
    [array writeToFile:filename  atomically:YES];
}

+ (NSDictionary *)getLoginPlist:(NSString *)str
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:str];
    NSLog(@"%@",filename);
    NSDictionary * dic=[[NSDictionary alloc] initWithContentsOfFile:filename];
    return dic;
}

+(void)locationStateCheck
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ||
                                                        [CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)) {
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        [[RunAlert ShareInstance] ShowAlertWithTitle:@"打开定位开关" withMessage:@"定位服务尚未打开,请进入系统[设置]>[隐私]>[定位服务]中打开定位,并允许跑腿使用定位服务" withCancelTitle:@"取消" withOtherTitle:@"立即开启" withAlertCompleteBlock:^(NSInteger index) {
            
            NSURL  *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        } withAlertCancelBlock:^(NSInteger index) {
        }];
    }
}

+(UIImage *)imageWithImage:(UIImage *)image scaleTosize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(BOOL)isRecorderFileExistwithStrPath:(NSString *)path
{
    NSFileManager  *Fm = [NSFileManager defaultManager];
    if([Fm fileExistsAtPath:path]) {
        return YES;
    }else{
        return NO;
    }
}

@end
