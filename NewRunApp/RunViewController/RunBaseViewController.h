//
//  RunBaseViewController.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LeftBtnHasImg = 0,  //有图片
    LeftBtnHasTitle,   //有title
    LeftBtnHasAll,    //既有图片还有tit
} LeftBtnType;

@interface RunBaseViewController : UIViewController

//导航底部线
@property(nonatomic,strong)UIImageView *navBarHairlineImageView;
/**返回按钮*/
@property(nonatomic,strong)UIBarButtonItem  *backBarBtn;
/**右侧按钮*/
@property(nonatomic,strong)UIBarButtonItem  *rightBarBtn;
/**返回按钮类型*/
@property(nonatomic)LeftBtnType btnType;
/**列表需要创建的时候创建*/
@property (nonatomic,strong)UITableView  *tableView;

/**创建列表*/
- (void)buildTableView:(CGRect)frame withHeaderView:(UIView*)headerView withFooterView:(UIView*)footerView andAlwaysBounceVertical:(BOOL)isBounce Delegate:(id<UITableViewDelegate>)delegateVc DataSouce:(id<UITableViewDataSource>)dataVc sytle:(UITableViewStyle)astyle;
/**设置barItem*/
-(void)setNavBarWithTit:(NSString *)titStr leftImgName:(NSString *)leftImg leftTitstr:(NSString *)leftTit rightImgName:(NSString *)rightImg rightTitStr:(NSString *)rightTit;
/**设置背景图片*/
-(void)setNavBarBgImgWith:(NSString *)imgStr;
-(void)backBtnAction;
-(void)rightBtnAction;
/**绑定viewModel*/
-(void)bindViewModel;
/**绑定事件*/
-(void)bindAction;
/**初始化子视图*/
-(void)buildSubViews;

@end
