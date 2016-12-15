//
//  RunHttpManager.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunHttpManager.h"

@implementation RunHttpManager

+ (RunHttpManager *)sharedManager
{
    static RunHttpManager *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[RunHttpManager alloc] init];
    });
    return shareInstance;
}

- (AFHTTPRequestOperation *)requestNewWithURL:(NSString *)urlString
                                       params:(NSMutableDictionary *)params
                                   httpMethod:(NSString *)httpMethod
                                CompleteBlock:(RequestFinishBlock)successBlock
                                    failBlock:(RequestFailedBlock)FailBlock
{
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    
    //如果登录要传token和Uid
    if ([GolbalManager sharedManager].isLogin) {
        if ([GolbalManager sharedManager].loginInfo.UserId!=0 && [GolbalManager sharedManager].loginInfo.UserToken!=nil) {
            [params setObject:[GolbalManager sharedManager].loginInfo.UserToken forKey:@"token"];
            [params setObject:[GolbalManager sharedManager].loginInfo.UserId forKey:@"uid"];
        }
    }
    
    if (![urlString hasPrefix:@"http://"]) {
        urlString = [BaseURL stringByAppendingFormat:@"%@",urlString];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20;
    AFHTTPRequestOperation*op;
    if ([httpMethod isEqualToString:@"GET"] ) {
        
        op = [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            if (successBlock) {

                successBlock(responseObject);
                
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            if (FailBlock) {
                FailBlock(error);
            }
        }];
    }else{
        op = [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            if (successBlock) {
                
                successBlock(responseObject);
                
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            if (FailBlock) {
                FailBlock(error);
            }
        }];
    }
    
    return op;
}
@end
