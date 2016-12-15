//
//  RunLoginViewController.m
//  NewRunApp
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunLoginViewController.h"
#import "RunRegisterViewController.h"
#import "RunFindPwdViewController.h"
#import "RunAgrmentViewController.h"
#import "RunLoginView.h"
#import "LoginViewModel.h"

@interface RunLoginViewController ()

@property(nonatomic,strong)RunLoginView *loginView;

@property(nonatomic,strong)LoginViewModel  *viewModel;

@end

@implementation RunLoginViewController

-(RunLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[RunLoginView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    return _loginView;
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
    [self.view addSubview:self.loginView];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"登录" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:nil];
    
    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)bindViewModel
{
    //绑定输入框
    @weakify(self);
    [self.loginView.phoneTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
        self.viewModel.phoneStr = value;
        [self changeBtnState];
    }];
    
    [self.loginView.pwdTextField.textField oberverTextChanged:^(id value){
        @strongify(self);
        self.viewModel.pwdStr = value;
        [self changeBtnState];
    }];
}

-(void)bindAction
{
    @weakify(self);
    //忘记密码
    [[self.loginView.forgetPwdBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.loginView setKeyBoardHide];
        RunFindPwdViewController  *findPwdVc = [[RunFindPwdViewController alloc] init];
        [self.navigationController pushViewController:findPwdVc animated:YES];
    }];
    //登录
    [[self.loginView.finishBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.loginView setKeyBoardHide];
        [self.viewModel RunLoginWithView:self.view withFinishBlock:^(BOOL finish) {
            @strongify(self);
        }];
    }];
    
    //协议
    [[self.loginView.agreementBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.loginView setKeyBoardHide];
        RunAgrmentViewController  *agreementVc = [[RunAgrmentViewController alloc] init];
        [self.navigationController pushViewController:agreementVc animated:YES];

    }];

    //注册
    [[self.loginView.registerBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.loginView setKeyBoardHide];

        RunRegisterViewController *registerVc = [[RunRegisterViewController alloc] init];
        [self.navigationController pushViewController:registerVc animated:YES];
    }];
}

-(void)changeBtnState
{
    if (self.viewModel.phoneStr.length>0 && self.viewModel.pwdStr.length>0) {
        
        [self.loginView.finishBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.loginView.finishBtn setBackgroundColor:RGBColor(0, 205, 198, 1)];
        
    }else{
        
        [self.loginView.finishBtn setBackgroundColor:[UIColor clearColor]];
        [self.loginView.finishBtn setBackgroundImage:[UIImage imageNamed:@"butt_bg"] forState:UIControlStateNormal];
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
