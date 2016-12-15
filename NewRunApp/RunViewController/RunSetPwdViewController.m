//
//  RunSetPwdViewController.m
//  NewRunApp
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunSetPwdViewController.h"
#import "RunSetPwdView.h"

@interface RunSetPwdViewController ()

@property(nonatomic,strong)RunSetPwdView  *setPwdView;

@end

@implementation RunSetPwdViewController

#pragma --mark lazy loading--
-(RunSetPwdView *)setPwdView
{
    if (!_setPwdView) {
        _setPwdView = [[RunSetPwdView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    return _setPwdView;
}

-(void)buildSubViews
{
    [self.view  addSubview:self.setPwdView];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"修改密码" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:nil];
    
    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)bindViewModel
{
    //绑定输入框
    @weakify(self);
    [self.setPwdView.oldPwdTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
    }];
    
    [self.setPwdView.newstPwdTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
    }];
    
    [self.setPwdView.conFirmPwdTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
    }];
}

-(void)bindAction
{
    @weakify(self);
    //设置密码
    [[self.setPwdView.finishBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.setPwdView setKeyBoardHide];

    }];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
