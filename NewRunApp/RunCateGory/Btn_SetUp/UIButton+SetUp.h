//
//  UIButton+SetUp.h
//  PingApp
//
//  Created by 赵玖录 on 15/8/27.
//  Copyright (c) 2015年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SetUp)
+(UIButton *)createBtnWithnorImage:(NSString *)norImage hlImage:(NSString *)hlImage target:(id)target action:(SEL)action;
+(UIButton *)createBtnWithnorImage:(NSString *)norImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
+(UIButton *)createBtnWithnorImage:(NSString *)norImage hlImage:(NSString *)hlImage title:(NSString *)title target:(id)target action:(SEL)action;
+(UIButton *)createBtnWithTitle:(NSString *)title nColor:(UIColor *)nColor slColor:(UIColor *)sColor target:(id)target action:(SEL)action;
+(UIButton *)createBtnWithnorImage:(UIImage *)image target:(id)target action:(SEL)action;
+(UIButton *)createBtnWithnorBGImage:(NSString *)norImage selectedBGImage:(NSString *)selectedImage target:(id)target action:(SEL)action;

@end
