//
//  RunSetNameView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunCustomTextField.h"


@interface RunSetNameView : UIView

//姓名输入框
@property(nonatomic,strong)RunCustomTextField *nameTextField;
//完成按钮
@property(nonatomic,strong)UIButton  *finishBtn;

-(void)setKeyBoardHide;

@end
