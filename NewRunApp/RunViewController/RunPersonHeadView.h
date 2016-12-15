//
//  RunPersonHeadView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved

#import <UIKit/UIKit.h>

@interface RunPersonHeadView : UIView

//修改头像
@property(nonatomic,strong)UIButton *carmerBtn;
//用户头像
@property(nonatomic,strong)UIImage  *userImg;

//刷新用户数据
-(void)reloadPerSonData;
@end
