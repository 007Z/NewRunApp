//
//  NSObject+YQBinding.h
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/2.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YQBinding)

#pragma mark -
#pragma mark - Binding

- (void)observeKeypath:(NSString *)keyPath withChangeBlock:(void (^)(id change))block;
- (void)observeSets:(NSString *)keyPath withChangeBlock:(void (^)(id change))block;
- (void)unbind;

@end
