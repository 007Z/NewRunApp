//
//  RunRegisterViewController.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunRegisterViewController.h"
#import "RunAgrmentViewController.h"
#import "RunRegisterView.h"
#import "LoginViewModel.h"

@interface RunRegisterViewController ()

@property(nonatomic,strong)RunRegisterView  *registerView;

@property(nonatomic,strong)LoginViewModel  *viewModel;

@end

@implementation RunRegisterViewController

#pragma --mark Lazy Loading-
-(RunRegisterView *)registerView
{
    if (!_registerView) {
        _registerView = [[RunRegisterView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    return _registerView;
}

-(LoginViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

-(void)buildSubViews
{
    [self.view addSubview:self.registerView];
    self.registerView.msg = @"为方便配送员联系，请验证手机";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"注册" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:nil];
    
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
    
    //协议
    [[self.registerView.agreeMentBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.registerView setKeyBoardHide];
        RunAgrmentViewController  *agreementVc = [[RunAgrmentViewController alloc] init];
        [self.navigationController pushViewController:agreementVc animated:YES];
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
