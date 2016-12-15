//
//  RunSetNameView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunSetNameView.h"

@implementation RunSetNameView

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
    _nameTextField = [[RunCustomTextField alloc] init];
    _nameTextField.placeholder = @"您的昵称";
    [self addSubview:_nameTextField];
    
    _finishBtn = [UIButton createBtnWithnorBGImage:@"add_butt" selectedBGImage:@"add_butt" target:self action:nil];
    _finishBtn.titleLabel.font = FONT_(16);
    [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_finishBtn setTitleColor:RGBColor(126, 114, 7, 1) forState:UIControlStateNormal];
    [self addSubview:_finishBtn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _nameTextField.frame = CGRectMake(RESIZE_UI(23),RESIZE_UI(38),self.width-RESIZE_UI(46),RESIZE_UI(45));
    
    _finishBtn.frame = CGRectMake((self.width-RESIZE_UI(157))/2,_nameTextField.bottom+40,RESIZE_UI(157),45);
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
    [self.nameTextField textResignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
