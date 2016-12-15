//
//  CityPickerView.h
//  NewRunApp
//  Created by ZHAO on 21/9/15.
//  Copyright (c) 2015年 赵玖录. All rights reserved.

#import <UIKit/UIKit.h>

@interface CityPickerView : UIView

//确定按钮
@property(nonatomic,strong)UIButton  *sureBtn;

//选择过的地址
@property(nonatomic,strong)NSString  *address;

//显示
-(void)showPicker;

//隐藏
-(void)hidePicker;

-(void)showInView:(UIView *)view;
@end
