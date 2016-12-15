//
//  RunSetPwdView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunSetPwdView.h"

@implementation RunSetPwdView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initsubViews];
    }
    
    return self;
}

-(void)initsubViews
{
    _oldPwdTextField = [[RunCustomTextField alloc] init];
    _oldPwdTextField.placeholder = @"旧密码";
    [self addSubview:_oldPwdTextField];
    
    _newstPwdTextField = [[RunCustomTextField alloc] init];
    _newstPwdTextField.placeholder = @"新密码";
    [self addSubview:_newstPwdTextField];
    
    _conFirmPwdTextField = [[RunCustomTextField alloc] init];
    _conFirmPwdTextField.placeholder = @"确认密码";
    [self addSubview:_conFirmPwdTextField];
    
    _finishBtn = [UIButton createBtnWithnorBGImage:@"add_butt" selectedBGImage:@"add_butt" target:self action:nil];
    _finishBtn.titleLabel.font = FONT_(16);
    [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_finishBtn setTitleColor:RGBColor(126, 114, 7, 1) forState:UIControlStateNormal];
    [self addSubview:_finishBtn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _oldPwdTextField.frame = CGRectMake(RESIZE_UI(23),RESIZE_UI(38),self.width-RESIZE_UI(46),RESIZE_UI(45));
    
    _newstPwdTextField.frame = CGRectMake(_oldPwdTextField.left,_oldPwdTextField.bottom+10,_oldPwdTextField.width,_oldPwdTextField.height);
    _conFirmPwdTextField.frame = CGRectMake(_newstPwdTextField.left,_newstPwdTextField.bottom+10,_newstPwdTextField.width,_newstPwdTextField.height);
    _finishBtn.frame = CGRectMake((self.width-RESIZE_UI(157))/2,_conFirmPwdTextField.bottom+40,RESIZE_UI(157),45);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    @weakify(self);
    [touches enumerateObjectsUsingBlock:^(UITouch *touch ,BOOL *stop){
        
        @strongify(self);
        if (![touch.view isKindOfClass:[RunCustomTextField class]]) {
            
            [self setKeyBoardHide];
            
        } else {
            return ;
        }
    }];
}

-(void)setKeyBoardHide
{
    [self.oldPwdTextField textResignFirstResponder];
    [self.newstPwdTextField textResignFirstResponder];
    [self.conFirmPwdTextField textResignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
