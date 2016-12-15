//  RunLoginView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunLoginView.h"

@interface RunLoginView ()

{
    UIImageView  *_line;
    UIImageView  *_towLine;
    UILabel      *_acountLab;
    UILabel      *_agreementLab;
}

@end

@implementation RunLoginView

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
    _phoneTextField = [[RunCustomTextField alloc] init];
    _phoneTextField.placeholder = @"您的手机号码";
    [self addSubview:_phoneTextField];
    _phoneTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _pwdTextField = [[RunCustomTextField alloc] init];
    _pwdTextField.placeholder = @"您的密码";
    [self addSubview:_pwdTextField];
    
    _forgetPwdBtn = [UIButton createBtnWithTitle:@"忘记密码?" nColor:RGBColor(186, 188, 187, 1) slColor:RGBColor(186, 188, 187, 1) target:self action:nil];
    _forgetPwdBtn.titleLabel.font = FONT_(14);
    [self addSubview:_forgetPwdBtn];
    
    _line = [[UIImageView alloc] init];
    _line.backgroundColor = RGBColor(170, 170, 170, 1);
    [self addSubview:_line];
    
    _finishBtn = [UIButton createBtnWithTitle:@"完成" nColor:RGBColor(250, 250, 250, 1) slColor:RGBColor(250, 250, 250, 1) target:self action:nil];
    [_finishBtn setBackgroundImage:[UIImage imageNamed:@"butt_bg"] forState:UIControlStateNormal];
    _finishBtn.layer.cornerRadius = 4;
    _finishBtn.layer.masksToBounds = NO;
    [self addSubview:_finishBtn];
    
    _agreementLab = [[UILabel alloc] init];
    _agreementLab.textColor = RGBColor(85, 85, 85, 1);
    _agreementLab.font = FONT_(13);
    _agreementLab.textAlignment = NSTextAlignmentRight;
    _agreementLab.text = @"点击”开始“，即表示同意";
    [self addSubview:_agreementLab];
    
    _agreementBtn = [UIButton createBtnWithTitle:@"《法律声明及隐私条款》" nColor:RGBColor(235, 172, 44, 1) slColor:RGBColor(235, 172, 44, 1) target:self action:nil];
    _agreementBtn.titleLabel.font = FONT_(13);
    [self addSubview:_agreementBtn];
    
    _towLine = [[UIImageView alloc] init];
    _towLine.backgroundColor = RGBColor(170, 170, 170, 1);
    [self addSubview:_towLine];
    
    _acountLab = [[UILabel alloc] init];
    _acountLab.textAlignment = NSTextAlignmentCenter;
    _acountLab.textColor = RGBColor(27, 204, 198, 1);
    _acountLab.font = FONT_(13);
    _acountLab.text = @"我还没有帐号";
    _acountLab.backgroundColor = BLACK_VIEW_COLOR;
    [self addSubview:_acountLab];
    
    _registerBtn = [UIButton createBtnWithTitle:@"我要注册" nColor:RGBColor(126, 114, 7, 1) slColor:RGBColor(126, 114, 7, 1) target:self action:nil];
    _registerBtn.titleLabel.font = FONT_(16);
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"add_butt"] forState:UIControlStateNormal];
    [self addSubview:_registerBtn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _phoneTextField.frame = CGRectMake(RESIZE_UI(23),RESIZE_UI(38),self.width-RESIZE_UI(23)*2,RESIZE_UI(45));
    _pwdTextField.frame = CGRectMake(_phoneTextField.left,_phoneTextField.bottom+10,_phoneTextField.width,_phoneTextField.height);
    _forgetPwdBtn.frame = CGRectMake(_pwdTextField.left+RESIZE_UI(15),_pwdTextField.bottom,65,45);
    _line.frame = CGRectMake(_forgetPwdBtn.left-2,_forgetPwdBtn.top+_forgetPwdBtn.height/2+10,_forgetPwdBtn.width+4,0.5);
    _finishBtn.frame = CGRectMake(_pwdTextField.left,_forgetPwdBtn.bottom,_pwdTextField.width,_pwdTextField.height);
    _agreementLab.frame = CGRectMake(_finishBtn.left,_finishBtn.bottom+10,_finishBtn.width/2,13);
    _agreementBtn.frame = CGRectMake(_agreementLab.right,_agreementLab.top+_agreementLab.height/2-33/2,150,33);
    
    _towLine.frame = CGRectMake(RESIZE_UI(15),_agreementLab.bottom+60,self.width-RESIZE_UI(30),0.5);
    _acountLab.frame = CGRectMake((self.width-110)/2,_towLine.bottom-21/2,110,21);
    
    _registerBtn.frame = CGRectMake((self.width-RESIZE_UI(133))/2,_acountLab.bottom+20,RESIZE_UI(133),45);
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
    [self.phoneTextField textResignFirstResponder];
    [self.pwdTextField textResignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
