//
//  RunCustomTextView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/14.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunCustomTextView.h"

@interface RunCustomTextView ()<UITextViewDelegate>

@property(nonatomic,strong)UIImageView *backImg;

@end

@implementation RunCustomTextView

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
    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    _textView.font = FONT_(14);
    _textView.textColor = [UIColor blackColor];
    _textView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textView];
    _textView.tintColor = RGBColor(27, 205, 198, 1);
    _textView.layer.cornerRadius = 4;
    _textView.layer.masksToBounds = YES;
    
    _placeholderLab = [[UILabel alloc] init];
    _placeholderLab.textColor = RGBColor(184, 182, 182, 1);
    _placeholderLab.font = FONT_(14);
    _placeholderLab.text = @"请输入信息";
    [self addSubview:_placeholderLab];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backImg.frame = CGRectMake(0,0,self.width,self.height);
    _textView.frame = CGRectMake(RESIZE_UI(10),0,self.width-RESIZE_UI(20),self.height);
    _placeholderLab.frame = CGRectMake(RESIZE_UI(15),RESIZE_UI(10),self.width-RESIZE_UI(20),13);
}

#pragma --mark UItextViewDelegate --
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _backImg.highlighted = YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
         _placeholderLab.hidden = YES;
    }else{
        _placeholderLab.hidden = NO;
    }
    
    if (self.textChangeBlock) {
        self.textChangeBlock(textView.text);
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self textViewResignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)checkPlaceholderState
{
    if (_textView.text.length>0) {
        _placeholderLab.hidden = YES;
    }else{
        _placeholderLab.hidden = NO;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _backImg.highlighted = NO;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeholderLab.text = _placeholder;
}

-(void)textViewResignFirstResponder
{
    [_textView resignFirstResponder];
}

@end
