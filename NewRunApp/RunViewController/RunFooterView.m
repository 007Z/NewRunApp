//
//  RunFooterView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunFooterView.h"

@implementation RunFooterView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    self.backgroundColor = [UIColor clearColor];
    _loginOutBtn = [UIButton createBtnWithTitle:@"退出登录" nColor:RGBColor(126, 114, 7, 1) slColor:RGBColor(126, 114, 7, 1) target:self
                                         action:nil];
    [_loginOutBtn setBackgroundImage:[UIImage imageNamed:@"add_butt"] forState:UIControlStateNormal];
    [self addSubview:_loginOutBtn];
}

-(void)layoutSubviews
{
    _loginOutBtn.frame = CGRectMake((self.width-RESIZE_UI(269/2))/2,RESIZE_UI(90),RESIZE_UI(269/2),RESIZE_UI(45));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
