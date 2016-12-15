//
//  LoginViewModel.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "LoginViewModel.h"

@implementation LoginViewModel

-(void)RunLoginWithView:(UIView *)view withFinishBlock:(void(^)(BOOL))finishBlock
{
    if ([self checkValue]) {
        
        NSMutableDictionary  *parm = [NSMutableDictionary dictionary];
        CLLocationCoordinate2D  Coordinate = [GolbalManager sharedManager].Coordinate;
        [parm setObject:self.phoneStr forKey:@"phonenum"];
        //[parm setObject:[GolbalManager sharedManager].pushInfo.channel_id forKey:@"phonemark"];
        [parm setObject:[RunComment md5:self.pwdStr] forKey:@"password"];
        [parm setObject:[NSString stringWithFormat:@"%f",Coordinate.latitude] forKey:@"gpsY"];
        [parm setObject:[NSString stringWithFormat:@"%f",Coordinate.longitude] forKey:@"gpsX"];
        [parm setObject:@"1" forKey:@"deviceType"];
        
        [RunHttpResult fecthLoginData:parm success:^(NSDictionary *result) {
            
        } failture:^(NSError *error) {
            
        }];
    }
}

//判断数据
-(BOOL)checkValue
{
    if (self.phoneStr.length == 0 || self.pwdStr.length == 0) {
        [RunComment showAlert:@"请输入手机号或密码"];
        return NO;
    }else{
        if (TELNUMCHECK(self.phoneStr) && self.phoneStr.length == 11) {
            return YES;
        }else{
            [RunComment showAlert:@"请输入正确的手机号"];
            return NO;
        }
    }
}
@end
