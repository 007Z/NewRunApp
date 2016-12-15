//
//  UIButton+YQResponsiveSupport.m
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/1.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import "UIControl+YQResponsiveSupport.h"
#include <objc/runtime.h>

@implementation UIControl (YQResponsiveSupport)


- (void (^)(id sender))nextBlock {
    return objc_getAssociatedObject(self, @selector(nextBlock));
}

- (void)setNextBlock:(void (^)(id sender))nextBlock {
    objc_setAssociatedObject(self, @selector(nextBlock), nextBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (instancetype)addActionForControlEvents:(UIControlEvents)controlEvents {

    [self addTarget:self action:@selector(sendNext:) forControlEvents:controlEvents];

    return self;

}



- (void)sendNext:(id)value {
    @synchronized (self) {
        self.nextBlock(value);
    }
}

- (void)perform:(void(^)(id sender))nextBlock {

    self.nextBlock = nextBlock;
    
}

- (void)dealloc {
    self.nextBlock = nil;
    [self removeTarget:self action:@selector(sendNext:) forControlEvents:UIControlEventTouchUpInside];
}


@end
