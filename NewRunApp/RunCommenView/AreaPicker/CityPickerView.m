//
//  CityPickerView.m
//  NewRunApp
//
//  Created by ZHAO on 21/9/15.
//  Copyright (c) 2015年 赵玖录. All rights reserved.

#import "CityPickerView.h"
#import "HZAreaPickerView.h"

@interface CityPickerView()<HZAreaPickerDelegate>
{
    CGRect originFrame;
}
@property(nonatomic,strong)UIButton *shadowBtn;
@property(nonatomic,strong)UILabel  *Line1;
@property(nonatomic,strong)UIButton  *CancelBtn;
@property(nonatomic,strong)UILabel  *Titla;
@property(nonatomic,strong)UILabel  *Line2;
@property(nonatomic,strong)UIView   *BottomView;
@property(nonatomic,strong)HZAreaPickerView *locatePicker;

@end
@implementation CityPickerView

-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        
        originFrame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self initGUI];
    }
    return self;
}

-(void)initGUI
{
    _Line1 = [[UILabel alloc] init];
    _Line1.backgroundColor = RGBColor(180, 181, 182, 1);
    [self addSubview:_Line1];
    
    _CancelBtn = [UIButton createBtnWithnorBGImage:@"" selectedBGImage:@"" target:self action:@selector(cancelAction)];
    [_CancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_CancelBtn setTitleColor:RGBColor(47, 162, 168, 1) forState:UIControlStateNormal];
    _CancelBtn.titleLabel.font = FONT_(15);
    [self addSubview:_CancelBtn];
    
    _Titla = [[UILabel alloc] init];
    _Titla.text = @"选取城市";
    _Titla.textAlignment = NSTextAlignmentCenter;
    _Titla.font = FONT_(18);
    _Titla.textColor = RGBColor(47, 162, 168, 1);
    [self addSubview:_Titla];
    
    _sureBtn = [UIButton createBtnWithnorBGImage:@"" selectedBGImage:@"" target:self action:nil];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:RGBColor(47, 162, 168, 1) forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = FONT_(15);
    [self addSubview:_sureBtn];

    _Line2 = [[UILabel alloc] init];
    _Line2.backgroundColor = RGBColor(180, 181, 182, 1);
    [self addSubview:_Line2];

    _BottomView = [[UIView alloc] init];
    _BottomView.backgroundColor = [UIColor redColor];
    [self addSubview:_BottomView];
    
    _address = @"北京  通州";
    _locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    _locatePicker.delegate = self;
    [self addSubview:_locatePicker];
    
    _shadowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shadowBtn.alpha = 0;
    _shadowBtn.hidden = YES;
    _shadowBtn.backgroundColor = [UIColor clearColor];
    [_shadowBtn addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews
{
    _Line1.frame = CGRectMake(0,0,self.width,RESIZE_UI(0.2));
    _CancelBtn.frame = CGRectMake(RESIZE_UI(10),_Line1.bottom,RESIZE_UI(45), RESIZE_UI(45));
    _Titla.frame = CGRectMake((self.width-RESIZE_UI(160))/2,_CancelBtn.top+_CancelBtn.height/2-RESIZE_UI(45)/2, RESIZE_UI(160), RESIZE_UI(45));
    _sureBtn.frame = CGRectMake(self.width-RESIZE_UI(55),_CancelBtn.top, RESIZE_UI(45), RESIZE_UI(45));
    _Line2.frame = CGRectMake(0,_sureBtn.bottom,self.width,RESIZE_UI(0.2));
    _BottomView.frame = CGRectMake(0,_Line2.bottom, self.width,self.height-_Line2.bottom);
    _locatePicker.frame =  CGRectMake(0,_Line2.bottom, self.width,self.height-_Line2.bottom);
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    _address = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
}

//显示
-(void)showPicker
{
    self.shadowBtn.alpha = 1;
    self.shadowBtn.hidden = NO;
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        
        CGRect frame = self.frame;
        frame.origin.y -= self.height;
        self.frame = frame;
        self.shadowBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
}

//隐藏
-(void)hidePicker
{
    self.shadowBtn.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.shadowBtn.backgroundColor = [UIColor clearColor];
        self.shadowBtn.hidden = YES;
        
        self.frame = originFrame;
    }];
}

-(void)showInView:(UIView *)view
{
    _shadowBtn.frame = CGRectMake(0, 0,CGRectGetWidth(view.bounds),CGRectGetHeight(view.bounds));
    [view addSubview:_shadowBtn];
    [view addSubview:self];
}

//取消
-(void)cancelAction
{
    [self hidePicker];
}

-(void)hideAction
{
    [self hidePicker];
}

@end
