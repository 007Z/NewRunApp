//
//  YQAction.h
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/1.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YQDisposable;
@protocol YQActionDelegate <NSObject>

@required
- (void)sendNext:(id)value;

@end
@interface YQAction : NSObject <YQActionDelegate>

@property (nonatomic, copy) void(^delegateBlock)(id <YQActionDelegate> delegate);

+ (instancetype)creatYQAction:(void (^)(id <YQActionDelegate> delegate))block;

- (void)perform:(void(^)(id sender))nextBlock;

@end
