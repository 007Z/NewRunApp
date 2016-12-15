//  RunCustomTextField.m
//  NewRunApp
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunCustomTextField.h"

@interface RunCustomTextField ()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView  *backImg;

@end

@implementation RunCustomTextField

-(id)init
{
    self = [super init];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];

    }
    return self;
}

-(void)initSubViews
{
    _backImg = [[UIImageView alloc] init];
    _backImg.image = [UIImage imageNamed:@"register_input"];
    _backImg.highlightedImage = [UIImage imageNamed:@"register_input_hov"];
    [self addSubview:_backImg];
    
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.font = FONT_(14);
    _textField.tintColor = RGBColor(27, 205, 198, 1);
    _textField.textColor = [UIColor blackColor];
    _textField.backgroundColor = [UIColor clearColor];
    [self addSubview:_textField];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backImg.frame = CGRectMake(0,0,self.width,self.height);
    _textField.frame = CGRectMake(RESIZE_UI(15),0,self.width-RESIZE_UI(30),self.height);
}

#pragma --mark UITextFieldDelegate--
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _backImg.highlighted = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _backImg.highlighted = NO;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
}

-(void)textResignFirstResponder
{
    [_textField resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
