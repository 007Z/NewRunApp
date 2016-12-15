//
//  UIButton+YQResponsiveSupport.h
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/1.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YQResponsiveSupport)

@property (nonatomic, copy, readonly) void(^nextBlock)(id sender);
- (instancetype)addActionForControlEvents:(UIControlEvents)controlEvents;
- (void)perform:(void(^)(id sender))nextBlock;
@end
