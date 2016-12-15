//
//  RunCustomTextView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/14.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^textDidChangeBlock)(id value);

@interface RunCustomTextView : UIView

@property(nonatomic,strong)UITextView  *textView;

@property(nonatomic,strong)UILabel *placeholderLab;

@property(nonatomic,copy)NSString  *placeholder;

@property(nonatomic,copy)textDidChangeBlock textChangeBlock;

//消失第一响应
-(void)textViewResignFirstResponder;
//判断placeholderLab是否隐藏
-(void)checkPlaceholderState;
@end
