//
//  RunPerSonViewModel.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "RunBaseViewModel.h"

@interface RunPerSonViewModel : RunBaseViewModel

@property(nonatomic,strong)NSArray *dataSource;

-(void)setDefaultData;
@end
