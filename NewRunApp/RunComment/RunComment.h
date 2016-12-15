//
//  RunComment.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunComment : NSObject

//提示语
+ (void)showAlert:(NSString*)alertString;
+ (void)showAlert:(NSString*)alertString withImgString:(NSString *)imgStr;

//MD5加密
+(NSString *) md5: (NSString *) inPutText;
//保存数据至本地
+(void)writeLoginPlist:(NSDictionary*)aDic string:(NSString*)str;
//取本地数据
+ (NSDictionary *)getLoginPlist:(NSString *)str;
//判断定位是否打开
+(void)locationStateCheck;
//图片压缩
+(UIImage *)imageWithImage:(UIImage *)image scaleTosize:(CGSize)newSize;
//录音文件是否存在
+(BOOL)isRecorderFileExistwithStrPath:(NSString *)path;
@end
