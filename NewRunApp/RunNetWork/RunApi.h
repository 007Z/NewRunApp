//
//  RunApi.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunHttpResult.h"

@interface RunApi : NSObject

extern NSString *const BaseURL;

/**注册用户*/
extern NSString *const RegisterUrl;
/**登录*/
extern NSString *const LoginUrl;
/**用户下单*/
extern NSString *const StartOrderUrl;
/**添加常用地址*/
extern NSString *const AddAddressUrl;
/**获取添加地址*/
extern NSString *const GetAllAddressUrl;
/**催单*/
extern NSString *const RemindOrderUrl;
/**配送员坐标*/
extern NSString *const WorkerLocatUrl;
/**取消订单*/
extern NSString *const CancelOrderUrl;
/**更新用户信息*/
extern NSString *const UpdateUseDataUrl;
/**删除历史地址*/
extern NSString *const DeleAddressUrl;
/**用户充重置密码*/
extern NSString *const ReSetPwdUrl;
/**用户订单状态*/
extern NSString *const UserCheckOrdState;
@end
