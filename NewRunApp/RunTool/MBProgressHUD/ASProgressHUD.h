//
//  ASProgressHUD.h
//  ishangzu
//
//  Created by 赵玖录 on 16/3/6.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASProgressHUD :UIView

-(id)initWithView:(UIView *)view;

+(NSArray *)allHUDsForView:(UIView *)view;
-(void)hide:(BOOL)isHide;
-(void)showInView:(UIView *)view;
@end
