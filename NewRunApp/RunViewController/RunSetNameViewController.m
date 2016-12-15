//
//  RunSetNameViewController.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunSetNameViewController.h"
#import "RunSetNameView.h"

@interface RunSetNameViewController ()

@property(nonatomic,strong)RunSetNameView  *setNameView;
@end

@implementation RunSetNameViewController

#pragma --mark --lazy loading--
-(RunSetNameView *)setNameView
{
    if (!_setNameView) {
        _setNameView = [[RunSetNameView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    
    return _setNameView;
}

-(void)buildSubViews
{
    [self.view addSubview:self.setNameView];
}

- (void)viewDidLoad {
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
    [self.setNameView.nameTextField.textField oberverTextChanged:^(id value){
        
        @strongify(self);
    }];
}

-(void)bindAction
{
    @weakify(self);
    //完成
    [[self.setNameView.finishBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        [self.setNameView setKeyBoardHide];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
