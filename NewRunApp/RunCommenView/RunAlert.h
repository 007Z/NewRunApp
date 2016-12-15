//
//  RunAlert.h
//  NewRunApp
//
//  Created by wojuios on 15/10/15.
//  Copyright © 2015年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertCompleteBlock)(NSInteger index);
typedef void(^AlertCancelBlock)(NSInteger index);

@interface RunAlert : NSObject<UIAlertViewDelegate>

@property(nonatomic,copy)AlertCompleteBlock  completeBlock;
@property(nonatomic,copy)AlertCancelBlock    cancelBlock;

+(RunAlert *)ShareInstance;

-(void)ShowAlertWithTitle:(NSString *)tit
              withMessage:(NSString *)msg
          withCancelTitle:(NSString *)cancelTit
           withOtherTitle:(NSString *)otherTit
   withAlertCompleteBlock:(AlertCompleteBlock)complete withAlertCancelBlock:(AlertCancelBlock)cancel;
@end
