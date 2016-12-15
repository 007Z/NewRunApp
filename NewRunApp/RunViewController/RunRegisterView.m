//
//  RegisterView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunRegisterView.h"

@interface RunRegisterView ()
{
    UILabel  *_agreeMentLab;
    UILabel  *_msgLab; //提示语标签
}
@end

@implementation RunRegisterView

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
    _msgLab = [[UILabel alloc] init];
    _msgLab.textColor = RGBColor(92, 93, 94, 1);
    _msgLab.font = FONT_(14);
    _msgLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_msgLab];
    
    _phoneTextField = [[RunCustomTextField alloc] init];
    _phoneTextField.placeholder = @"您的手机号码";
    _phoneTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneTextField];
    
    _verCodeBtn = [UIButton createBtnWithTitle:@"获取验证码" nColor:[UIColor whiteColor] slColor:[UIColor whiteColor] target:self action:nil];
    _verCodeBtn.titleLabel.font = FONT_(14);
    [_verCodeBtn setBackgroundImage:[UIImage imageNamed:@"ident_bg"] forState:UIControlStateNormal];
    [self addSubview:_verCodeBtn];
    
    _verCodeTextField = [[RunCustomTextField alloc] init];
    _verCodeTextField.placeholder = @"您的验证码";
    _verCodeTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_verCodeTextField];

    _pwdTextField = [[RunCustomTextField alloc] init];
    _pwdTextField.placeholder = @"您的密码";
    [self addSubview:_pwdTextField];
    
    _finishBtn = [UIButton createBtnWithTitle:@"完成" nColor:RGBColor(250, 250, 250, 1) slColor:RGBColor(250, 250, 250, 1) target:self action:nil];
    [_finishBtn setBackgroundImage:[UIImage imageNamed:@"butt_bg"] forState:UIControlStateNormal];
    _finishBtn.layer.cornerRadius = 4;
    _finishBtn.layer.masksToBounds = NO;
    [self addSubview:_finishBtn];

    _agreeMentLab = [[UILabel alloc] init];
    _agreeMentLab.textColor = RGBColor(85, 85, 85, 1);
    _agreeMentLab.font = FONT_(13);
    _agreeMentLab.textAlignment = NSTextAlignmentRight;
    _agreeMentLab.text = @"点击”开始“，即表示同意";
    [self addSubview:_agreeMentLab];
    
    _agreeMentBtn = [UIButton createBtnWithTitle:@"《法律声明及隐私条款》" nColor:RGBColor(235, 172, 44, 1) slColor:RGBColor(235, 172, 44, 1) target:self action:nil];
    _agreeMentBtn.titleLabel.font = FONT_(13);
    [self addSubview:_agreeMentBtn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _msgLab.frame = CGRectMake(0,RESIZE_UI(38),self.width,13);
    
    _verCodeBtn.frame = CGRectMake(self.width-RESIZE_UI(23)-90,_msgLab.bottom+20,90,RESIZE_UI(45));
    
    _phoneTextField.frame = CGRectMake(RESIZE_UI(23),_verCodeBtn.top,self.width-RESIZE_UI(46)-90-10,_verCodeBtn.height);
    
    _verCodeTextField.frame = CGRectMake(_phoneTextField.left,_phoneTextField.bottom+10, self.width-RESIZE_UI(46),_phoneTextField.height);
    
    _pwdTextField.frame = CGRectMake(_verCodeTextField.left,_verCodeTextField.bottom+10, _verCodeTextField.width,_verCodeTextField.height);
    
    _finishBtn.frame = CGRectMake(_pwdTextField.left,_pwdTextField.bottom+40,_pwdTextField.width,_pwdTextField.height);
    
    _agreeMentLab.frame = CGRectMake(_finishBtn.left,_finishBtn.bottom+10,_finishBtn.width/2,13);
    _agreeMentBtn.frame = CGRectMake(_agreeMentLab.right,_agreeMentLab.top+_agreeMentLab.height/2-33/2,150,33);
}

-(void)setBottomViewHide
{
    _agreeMentBtn.hidden = YES;
    _agreeMentLab.hidden = YES;
}

-(void)setMsg:(NSString *)msg
{
    _msg = msg;
    _msgLab.text = msg;
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
    [self.verCodeTextField textResignFirstResponder];
}

@end
