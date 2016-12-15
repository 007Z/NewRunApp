//
//  YQAction.m
//  ishangzu
//
//  Created by ishangzuIOS on 16/8/1.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import "YQAction.h"
#import "YQDisposable.h"
@interface YQAction ()


@property (nonatomic, copy) void(^nextBlock)(id sender);
@end

@implementation YQAction



+ (instancetype)creatYQAction:(void (^)(id <YQActionDelegate> delegate))block {
    YQAction *action = [[YQAction alloc]init];
    action->_delegateBlock = [block copy];
    if (action->_delegateBlock != nil) {
        action->_delegateBlock(action);
    }
    return action;
}

- (void)sendNext:(id)value {
    @synchronized (self) {
        void (^nextBlock)(id) = [self.nextBlock copy];
        if (nextBlock == nil) return;
        nextBlock(value);
    }
}

- (void)perform:(void(^)(id sender))nextBlock {

    self->_nextBlock = [nextBlock copy];
}



@end
