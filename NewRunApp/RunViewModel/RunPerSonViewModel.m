//
//  RunPerSonViewModel.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunPerSonViewModel.h"

@implementation RunPerSonViewModel

-(id)init
{
    self = [super init];
    if (self) {
        
        [self setDefaultData];
    }
    
    return self;
}

-(void)setDefaultData
{
    NSString  *UserTel = @"手机号码";
    if ([GolbalManager sharedManager].isLogin) {
        RunLoginInfo  *info = [GolbalManager sharedManager].loginInfo;
        UserTel = [NSString stringWithFormat:@"手机号码:%@",info.UserTel];
    }
    _dataSource=@[@{@"image":@"perso_ico1",@"text":UserTel},@{@"image":@"perso_ico2",@"text":@"设置昵称"},@{@"image":@"perso_ico3",@"text":@"修改密码"},@{@"image":@"perso_ico4",@"text":@"默认地址"}];
}

@end
