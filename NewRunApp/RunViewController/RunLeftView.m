//
//  RunLeftBtn.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/10.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunLeftView.h"

@interface RunLeftView ()
@property(nonatomic,strong)UIButton  *btn;
@end

@implementation RunLeftView

-(id)init
{
    if (self = [super init]) {
        
        [self initSubViews];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];

    }
    
    return self;
}

-(void)initSubViews
{
    self.backgroundColor = [UIColor clearColor];
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_btn];
    
    self.layer.cornerRadius = self.width/2;
    self.layer.masksToBounds = NO;
}

-(void)ReloadRunData
{
    [_btn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _btn.frame = CGRectMake(0, 0, self.width,self.height);
}


@end
