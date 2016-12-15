//
//  UITextField+YQResponsiveSupport.h
//  ishangzu
//
//  Created by ishangzuIOS on 16/7/29.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YQResponsiveSupport)

- (void)oberverTextChanged:(void(^)(id changed))block;


@end
