//
//  UITextField+YQResponsiveSupport.m
//  ishangzu
//
//  Created by ishangzuIOS on 16/7/29.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import "UITextField+YQResponsiveSupport.h"
#import <objc/runtime.h>

@implementation UITextField (YQResponsiveSupport)

- (void)oberverTextChanged:(void(^)(id changed))block {

    [[self addActionForControlEvents:UIControlEventEditingChanged]perform:^(UITextField *textField){
        if (block) {
            block(textField.text);
        }
    }];

}


@end
