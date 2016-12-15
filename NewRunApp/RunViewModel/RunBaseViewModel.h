//
//  RunBaseViewModel.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequstSuccessBlock)(id result);
typedef void(^RequstFailedBlock)(id result);
typedef void(^RequstCacheBlock)(id result);

@interface RunBaseViewModel : NSObject

@property (nonatomic, copy)RequstCacheBlock cacheBlock;
@property (nonatomic, copy)RequstFailedBlock failedBlock;
@property (nonatomic, copy)RequstSuccessBlock finishBlock;

@end
