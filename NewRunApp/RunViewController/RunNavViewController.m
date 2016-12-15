//  RunNavViewController.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunNavViewController.h"

@interface RunNavViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

//侧滑手势
@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@end

@implementation RunNavViewController

static RunNavViewController *baseNavigationController;

+ (instancetype)shareNavgationController {
    
    static RunNavViewController  *shareinstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareinstance = [[RunNavViewController alloc] init];
    });
    return shareinstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:NO];
    self.delegate = self;
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.navigationBar.barTintColor = RGBColor(27, 205, 198, 1);
    self.navigationBar.translucent = true;
     
    if (self.fullScreenPopGestureEnable) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
        [self.view addGestureRecognizer:self.popPanGesture];
        self.popPanGesture.maximumNumberOfTouches = 1;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

//解决某些情况push会卡死的情况
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (self.fullScreenPopGestureEnable) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        if (isRootVC) {
            [self.popPanGesture removeTarget:target action:action];
        } else {
            [self.popPanGesture addTarget:target action:action];
        }
    } else {
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
