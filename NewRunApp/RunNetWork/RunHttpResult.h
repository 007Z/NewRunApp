//
//  RunHttpResult.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunHttpManager.h"

@interface RunHttpResult : NSObject


/**
 * @brief   1.登录
 * @return  result(成功  失败)
 **/

+ (AFHTTPRequestOperation*)fecthLoginData:(NSMutableDictionary *)params success:(void (^)(NSDictionary *))successBlock failture:(void (^)(id))failtureBlock ;
@end
