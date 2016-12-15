//
//  RunCustomTextField.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunCustomTextField : UIView

@property(nonatomic,strong)UITextField  *textField;

@property(nonatomic,copy)NSString  *placeholder;

//消失第一响应
-(void)textResignFirstResponder;
@end
