//
//  RunHttpResult.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunHttpResult.h"

@implementation RunHttpResult

#pragma mark --登录

+ (AFHTTPRequestOperation*)fecthLoginData:(NSMutableDictionary *)params success:(void (^)(NSDictionary *))successBlock failture:(void (^)(id))failtureBlock
{
    AFHTTPRequestOperation  *op = [[RunHttpManager sharedManager] requestNewWithURL:LoginUrl params:params httpMethod:POSTHttpMethod CompleteBlock:^(id result) {
        
        successBlock(result);
        
    } failBlock:^(NSError *failed) {
       
        failtureBlock(failed);

    }];
    return op;
}
@end
