//
//  YQDisposable.h
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 3/16/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YQScopedDisposable;

/// A disposable encapsulates the work necessary to tear down and cleanup a
/// subscription.
@interface YQDisposable : NSObject

/// Whether the receiver has been disposed.
///
/// Use of this property is discouraged, since it may be set to `YES`
/// concurrently at any time.
///
/// This property is not KVO-compliant.
@property (atomic, assign, getter = isDisposed, readonly) BOOL disposed;

+ (instancetype)disposableWithBlock:(void (^)(void))block;

/// Performs the disposal work. Can be called multiple times, though subsequent
/// calls won't do anything.
- (void)dispose;


@end
