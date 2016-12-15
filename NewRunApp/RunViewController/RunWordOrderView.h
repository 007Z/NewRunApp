//
//  RunWordOrderView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/17.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextView.h"


@interface RunWordOrderView : UIView
//输入框
@property(nonatomic,strong)RunCustomTextView *textView;
//地址选择按钮
@property(nonatomic,strong)UIButton  *addressBtn;
//下单
@property(nonatomic,strong)UIButton  *orderBtn;

//显示
-(void)show;
//隐藏
-(void)hide;
//添加到父视图
-(void)showInView:(UIView *)view;
@end
