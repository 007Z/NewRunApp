//
//  RunAddressView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunAddressView.h"

@interface RunAddressView ()
{
    UILabel  *_lab;
    UILabel  *_detaiLab;
    UIImageView  *_arrowImg;
    UIImageView *_line;
}

@end

@implementation RunAddressView

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
    _lab = [[UILabel alloc] init];
    _lab.textColor = RGBColor(148, 148, 148, 1);
    _lab.font = FONT_(16);
    _lab.text = @"地址";
    [self addSubview:_lab];
    
    _addressLab = [[UILabel alloc] init];
    _addressLab.textColor = RGBColor(148, 148, 148, 1);
    _addressLab.font = FONT_(16);
    _addressLab.text = @"请选择省市区";
    [self addSubview:_addressLab];
    
    _arrowImg = [[UIImageView alloc] init];
    _arrowImg.image = [UIImage imageNamed:@"open_ico"];
    [self addSubview:_arrowImg];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_cityBtn];
    
    _line = [[UIImageView alloc] init];
    _line.backgroundColor = RGBColor(148, 148, 148, 1);
    [self addSubview:_line];
    
    _detaiLab = [[UILabel alloc] init];
    _detaiLab.textColor = RGBColor(148, 148, 148, 1);
    _detaiLab.font = FONT_(16);
    _detaiLab.text = @"详细地址";
    [self addSubview:_detaiLab];
    
    _runTextView = [[RunCustomTextView alloc] init];
    _runTextView.placeholder = @"在这里输入您的详细地址";
    [self addSubview:_runTextView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _lab.frame = CGRectMake(RESIZE_UI(23),RESIZE_UI(70), 40,13);
    _addressLab.frame = CGRectMake(_lab.right+20,_lab.top,self.width-_lab.right-20-RESIZE_UI(23)-10,13);
    _arrowImg.frame = CGRectMake(self.width-RESIZE_UI(23)-RESIZE_UI(9),_addressLab.top+_addressLab.height/2-RESIZE_UI(17/2),RESIZE_UI(9),RESIZE_UI(17));
    _cityBtn.frame = CGRectMake(_addressLab.left,_addressLab.top+_addressLab.height/2-RESIZE_UI(45/2),_addressLab.width,RESIZE_UI(45));
    _line.frame = CGRectMake(RESIZE_UI(23),_cityBtn.bottom,self.width-RESIZE_UI(46),0.5);
    _detaiLab.frame = CGRectMake(RESIZE_UI(23),_line.bottom+20,100,13);
    _runTextView.frame = CGRectMake(RESIZE_UI(23),_detaiLab.bottom+20,self.width-RESIZE_UI(46),RESIZE_UI(98));
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    @weakify(self);
    [touches enumerateObjectsUsingBlock:^(UITouch *touch ,BOOL *stop){
        
        @strongify(self);
        if (![touch.view isKindOfClass:[RunCustomTextView class]]) {
            
            [self setKeyBoardHide];
            
        } else {
            return ;
        }
    }];
}

-(void)setKeyBoardHide
{
    [self.runTextView textViewResignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
