//
//  RunAddressView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextView.h"

@interface RunAddressView : UIView
//地址
@property(nonatomic,strong)UILabel  *addressLab;
//详细地址输入框
@property(nonatomic,strong)RunCustomTextView *runTextView;
//省区按钮
@property(nonatomic,strong)UIButton  *cityBtn;

//键盘响应消失
-(void)setKeyBoardHide;
@end
