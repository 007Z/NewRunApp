//
//  UIButton+SetUp.m
//  PingApp
//
//  Created by 赵玖录 on 15/8/27.
//  Copyright (c) 2015年 赵玖录. All rights reserved.

#import "UIButton+SetUp.h"

@implementation UIButton (SetUp)
+(UIButton *)createBtnWithnorImage:(NSString *)norImage hlImage:(NSString *)hlImage target:(id)target action:(SEL)action
{
    UIButton  *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (norImage) {
        [Btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    
    if (hlImage) {
        [Btn setImage:[UIImage imageNamed:hlImage] forState:UIControlStateHighlighted];
    }
    
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return Btn;
}

+(UIButton *)createBtnWithnorImage:(NSString *)norImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton  *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (norImage) {
        [Btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    
    if (selectedImage) {
        [Btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return Btn;
}

+(UIButton *)createBtnWithnorImage:(NSString *)norImage hlImage:(NSString *)hlImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton  *Btn = [self createBtnWithnorImage:norImage hlImage:hlImage target:target action:action];
    [Btn setTitle:title forState:UIControlStateNormal];
    return Btn;
}

+(UIButton *)createBtnWithTitle:(NSString *)title nColor:(UIColor *)nColor slColor:(UIColor *)sColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:nColor forState:UIControlStateNormal];
    [btn setTitleColor:sColor forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return btn;
}

+(UIButton *)createBtnWithnorImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;

}

+(UIButton *)createBtnWithnorBGImage:(NSString *)norImage selectedBGImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;

}
@end
