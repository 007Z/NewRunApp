//
//  RunNavViewController.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunNavViewController : UINavigationController

/**<是否开启全屏侧滑返回手势*/
@property (nonatomic, assign) BOOL fullScreenPopGestureEnable;
/**<真正的viewControllers*/

+ (instancetype)shareNavgationController;

@end
