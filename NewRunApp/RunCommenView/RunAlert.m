//  RunAlert.m
//  NewRunApp
//  Created by wojuios on 15/10/15.
//  Copyright © 2015年 赵玖录. All rights reserved.

#import "RunAlert.h"

@implementation RunAlert

+(RunAlert *)ShareInstance
{
    static RunAlert  *_shareInstance = nil;
    static dispatch_once_t  OnceToken;
    dispatch_once(&OnceToken,^{
        _shareInstance = [[RunAlert alloc] init];
    });
    return _shareInstance;
}

-(void)ShowAlertWithTitle:(NSString *)tit
              withMessage:(NSString *)msg
          withCancelTitle:(NSString *)cancelTit
           withOtherTitle:(NSString *)otherTit
   withAlertCompleteBlock:(AlertCompleteBlock)complete withAlertCancelBlock:(AlertCancelBlock)cancel
{
    self.completeBlock = complete;
    self.cancelBlock = cancel;
    
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:tit message:msg delegate:self cancelButtonTitle:cancelTit otherButtonTitles:otherTit, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.cancelBlock) {
            self.cancelBlock(buttonIndex);
        }
    }else{
        if (self.completeBlock) {
            self.completeBlock(buttonIndex);
        }
    }
}
@end
