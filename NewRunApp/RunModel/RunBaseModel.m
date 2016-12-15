//
//  RunBaseModel.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/5.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunBaseModel.h"

@implementation RunBaseModel

- (void)setNilValueForKey:(NSString *)key
{
    [self setValue:@0 forKey:key];
}



+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end
