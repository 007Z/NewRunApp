//
//  RunBpushInfo.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/12.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunBaseModel.h"

@interface RunBpushInfo : RunBaseModel

/**应用iD*/
@property(nonatomic,strong)NSString *app_id;
/**推送用到此ID*/
@property(nonatomic,strong)NSString *channel_id;
/**请求ID*/
@property(nonatomic,strong)NSString *request_id;
/**用户id,唯一标示*/
@property(nonatomic,strong)NSString *user_id;

@end
