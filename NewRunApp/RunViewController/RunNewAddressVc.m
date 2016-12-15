//
//  RunNewAddressVc.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunNewAddressVc.h"
#import "RunAddressView.h"
#import "CityPickerView.h"

@interface RunNewAddressVc ()

@property(nonatomic,strong)RunAddressView  *addressView;

@property(nonatomic,strong)CityPickerView  *cityView;
@end

@implementation RunNewAddressVc

#pragma --mark Lazy loading--
-(RunAddressView *)addressView
{
    if (!_addressView) {
        _addressView = [[RunAddressView alloc] initWithFrame:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT)];
    }
    
    return _addressView;
}

-(CityPickerView *)cityView
{
    if (!_cityView) {
        _cityView = [[CityPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT,SCREEN_WIDTH,RESIZE_UI(263))];
    }
    return _cityView;
}

-(void)buildSubViews
{
    [self.view addSubview:self.addressView];
    [self.cityView showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"新增地址" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:@"完成"];

    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)bindViewModel
{
    //详细地址
    @weakify(self);
    self.addressView.runTextView.textChangeBlock = ^(id value){
        @strongify(self);
    };
}

-(void)bindAction
{
    @weakify(self);
    //选择省区
    [[self.addressView.cityBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        @strongify(self);
        
        [self.addressView setKeyBoardHide];
        [self.cityView showPicker];
    }];
    
    //确定所选省区
    [[self.cityView.sureBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        @strongify(self);
        
        self.addressView.addressLab.text = self.cityView.address;
        self.addressView.runTextView.textView.text = self.cityView.address;
        [self.addressView.runTextView checkPlaceholderState];
        [self.cityView hidePicker];
    }];
}

-(void)rightBtnAction
{
    [self.addressView setKeyBoardHide];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
