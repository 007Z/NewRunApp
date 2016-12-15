//
//  RunHttpManager.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

#define POSTHttpMethod  @"POST"
#define GETHttpMethod   @"GET"

typedef void(^RequestFinishBlock)(id result);
typedef void(^RequestFailedBlock)(NSError*failed);

@interface RunHttpManager : NSObject

+ (RunHttpManager *)sharedManager;

/*
 @method
 @param   urlString     请求路径
 @param   params        参数
 @param   httpMethod    get/post
 @param   finishBlack    成功回调
 @param   aFailBlock     失败回调
 @result                请求成功数据
 */
- (AFHTTPRequestOperation *)requestNewWithURL:(NSString *)urlString
                                       params:(NSMutableDictionary *)params
                                   httpMethod:(NSString *)httpMethod
                                CompleteBlock:(RequestFinishBlock)successBlock
                                    failBlock:(RequestFailedBlock)FailBlock;
@end
