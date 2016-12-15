//
//  RunPersonHeadView.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunPersonHeadView.h"

@interface RunPersonHeadView ()

//头像
@property(nonatomic,strong)UIImageView *userHeader;

@property(nonatomic,strong)UIImageView *carmerImg;
//用户昵称或手机号
@property(nonatomic,strong)UILabel *userPhone;

@end

@implementation RunPersonHeadView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBColor(27, 205, 198, 1);
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    _userHeader=[[UIImageView alloc]init];
    _userHeader.image=[UIImage imageNamed:@"pers_head"];
    
    [self addSubview:_userHeader];
    _userHeader.layer.cornerRadius = RESIZE_UI(100)/2;
    _userHeader.layer.masksToBounds = YES;
    
    _carmerImg = [[UIImageView alloc] init];
    _carmerImg.image = [UIImage imageNamed:@"camera"];
    [self addSubview:_carmerImg];
    
    _userPhone=[[UILabel alloc]init];
    _userPhone.font=FONT_(15);
    _userPhone.text=@"15836122525";
    _userPhone.textColor=[UIColor whiteColor];
    _userPhone.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_userPhone];
    
    _carmerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_carmerBtn];
}

-(void)layoutSubviews
{
    _userHeader.frame = CGRectMake((self.width-RESIZE_UI(100))/2, RESIZE_UI(20), RESIZE_UI(100), RESIZE_UI(100));
    _carmerImg.frame = CGRectMake(_userHeader.right-RESIZE_UI(58)/2,_userHeader.bottom-RESIZE_UI(58)/2, RESIZE_UI(58/2), RESIZE_UI(58/2));
    _userPhone.frame = CGRectMake(0, _userHeader.bottom+10,self.width,21);
    _carmerBtn.frame =  _userHeader.frame;
}

-(void)reloadPerSonData
{
    if ([GolbalManager sharedManager].isLogin) {
        RunLoginInfo  *info = [GolbalManager sharedManager].loginInfo;
        if (info.UserNilkName.length == 0 || info.UserNilkName == nil) {
            _userPhone.text = info.UserTel;
        }else{
            _userPhone.text = info.UserNilkName;
        }
        NSString  *imgStr = [GolbalManager sharedManager].loginInfo.UserHeadUrl;
        [_userHeader sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"pers_head"]];
    }else{
        _userPhone.text = @"未登录哦";
        _userHeader.image=[UIImage imageNamed:@"pers_head"];
    }
}

-(void)setUserImg:(UIImage *)userImg
{
    _userImg = userImg;
    [self.userHeader setImage:_userImg];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
