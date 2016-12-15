//
//  RunBottomView.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/10/11.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WordOrderCompleteBlock)();
typedef void(^VoiceOrderCompleteBlock)(NSInteger index);
@interface RunBottomView : UIView

@property(nonatomic,copy)WordOrderCompleteBlock wordOrderBlock;
@property(nonatomic,copy)VoiceOrderCompleteBlock voiceOrderBlock;
@end
