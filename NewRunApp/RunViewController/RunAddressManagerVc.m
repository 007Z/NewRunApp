//
//  RunAddressManagerVc.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunAddressManagerVc.h"
#import "RunNewAddressVc.h"

@interface RunAddressManagerVc ()

@end

@implementation RunAddressManagerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"地址管理" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:@"编辑"];

    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)rightBtnAction
{
    RunNewAddressVc  *newAddressVc = [[RunNewAddressVc alloc] init];
    [self.navigationController pushViewController:newAddressVc animated:YES];
}

-(void)bindViewModel
{
}

-(void)bindAction
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
