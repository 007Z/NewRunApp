//
//  RunForgetPwdViewController.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunFindPwdViewController.h"
#import "LoginViewModel.h"
#import "RunRegisterView.h"

@interface RunFindPwdViewController ()

@property(nonatomic,strong)RunRegisterView  *registerView;

@property(nonatomic,strong)LoginViewModel  *viewModel;

@end

@implementation RunFindPwdViewController

-(LoginViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

-(RunRegisterView *)registerView
{
    if (!_registerView) {
        _registerView = [[RunRegisterView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    return _registerView;
}

-(void)buildSubViews
{
    [self.view addSubview:self.registerView];
    [self.registerView setBottomViewHide];
    self.registerView.msg = @"为方便找回密码，请验证手机";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"忘记密码" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:nil];
    
    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)bindViewModel
{
    //绑定输入框
    @weakify(self);
    [self.registerView.phoneTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
        self.viewModel.phoneStr = value;
        [self changeBtnState];
    }];
    
    [self.registerView.verCodeTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
        self.viewModel.verCodeStr = value;
        [self changeBtnState];

    }];
    
    [self.registerView.pwdTextField.textField oberverTextChanged:^(id value){
        @strongify(self);
        self.viewModel.pwdStr = value;
        [self changeBtnState];
    }];
}

-(void)bindAction
{
    //验证码发送
    @weakify(self);
    [[self.registerView.verCodeBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.registerView setKeyBoardHide];
    }];
    
    //完成
    [[self.registerView.finishBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.registerView setKeyBoardHide];
    }];
}


-(void)changeBtnState
{
    if (self.viewModel.phoneStr.length>0 && self.viewModel.pwdStr.length>0 & self.viewModel.verCodeStr.length>0) {
        
        [self.registerView.finishBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.registerView.finishBtn setBackgroundColor:RGBColor(0, 205, 198, 1)];
        
    }else{
        
        [self.registerView.finishBtn setBackgroundColor:[UIColor clearColor]];
        [self.registerView.finishBtn setBackgroundImage:[UIImage imageNamed:@"butt_bg"] forState:UIControlStateNormal];
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
