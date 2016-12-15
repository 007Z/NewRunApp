//
//  NSObject+YQBinding.m
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/2.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import "NSObject+YQBinding.h"

@implementation NSObject (YQBinding)

- (void)observeKeypath:(NSString *)keyPath withChangeBlock:(void (^)(id change))block {
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        id changeObject = [change valueForKey:NSKeyValueChangeNewKey];
//        NSLog(@"change--%@",changeObject);
        if (block) {
            if ([changeObject isKindOfClass:[NSNull class]]) {
                changeObject = nil;
            }
            block(changeObject);
        }
    }];
}


- (void)observeSets:(NSString *)keyPath withChangeBlock:(void (^)(id change))block {
    [self.KVOControllerNonRetaining observe:self keyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        id changeObject = [change valueForKey:NSKeyValueChangeNewKey];
//        NSLog(@"change--%@",changeObject);
        if (block) {
            if ([changeObject isKindOfClass:[NSNull class]]) {
                changeObject = nil;
            }
            block(changeObject);
        }
    }];
}

- (void)unbind {
    [self fb_unobserveAll];
}


@end
