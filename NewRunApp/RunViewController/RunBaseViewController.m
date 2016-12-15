//
//  RunBaseViewController.m
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunBaseViewController.h"

@interface RunBaseViewController ()

@end

@implementation RunBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BLACK_VIEW_COLOR;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.navBarHairlineImageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)buildTableView:(CGRect)frame withHeaderView:(UIView*)headerView withFooterView:(UIView*)footerView andAlwaysBounceVertical:(BOOL)isBounce Delegate:(id<UITableViewDelegate>)delegateVc DataSouce:(id<UITableViewDataSource>)dataVc sytle:(UITableViewStyle)astyle
{
    _tableView = [[UITableView alloc]initWithFrame:frame style:astyle];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.alwaysBounceVertical=isBounce;
    _tableView.delegate=delegateVc;
    _tableView.dataSource=dataVc;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    if (headerView!=nil) {
        _tableView.tableHeaderView=headerView;
    }
    _tableView.backgroundColor = BLACK_VIEW_COLOR;
    if (footerView!=nil) {
        _tableView.tableFooterView=footerView;
    }
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(void)setNavBarWithTit:(NSString *)titStr leftImgName:(NSString *)leftImg leftTitstr:(NSString *)leftTit rightImgName:(NSString *)rightImg rightTitStr:(NSString *)rightTit
{
    self.title = titStr;
    
    if (leftImg.length>0) {
        self.btnType = LeftBtnHasImg;
    }
    
    if (leftTit.length>0) {
        
        self.btnType = LeftBtnHasTitle;
    }
    
    if (leftImg.length>0 && leftTit.length>0) {
        self.btnType = LeftBtnHasAll;
    }
    
    self.backBarBtn = [self createBarBtnItemWithWithStr:leftImg withTit:leftTit withType:self.btnType isLeft:YES];
    self.navigationItem.leftBarButtonItem = self.backBarBtn;
    
    if (rightImg.length>0) {
        self.btnType = LeftBtnHasImg;
    }
    
    if (rightTit.length>0) {
        
        self.btnType = LeftBtnHasTitle;
    }
    
    self.rightBarBtn = [self createBarBtnItemWithWithStr:rightImg withTit:rightTit withType:self.btnType isLeft:NO];
    self.navigationItem.rightBarButtonItem = self.rightBarBtn;
}

-(UIBarButtonItem *)createBarBtnItemWithWithStr:(NSString *)str withTit:(NSString *)titStr withType:(LeftBtnType)type isLeft:(BOOL)leftBar
{
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:RGBColor(250, 250, 250, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_(15);
    CGFloat  contentW = 0.0;
    if (titStr.length>0) {
        
        contentW = [NSMutableAttributedString getContentWidth:[[NSMutableAttributedString alloc] initWithString:titStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}] height:21];
    }
    
    switch (type) {
        case LeftBtnHasImg:
        {
            btn.frame = CGRectMake(0, 0, 40,40);
            [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            if (leftBar) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,15);
            }else{
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,15,0,-15);
            }
        }
            break;
        case LeftBtnHasTitle:
        {
            btn.frame = CGRectMake(0, 0,contentW,40);
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [btn setTitle:titStr forState:UIControlStateNormal];
        }
            break;
        case LeftBtnHasAll:
        {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,15);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,-35,0,0);
            btn.frame = CGRectMake(0, 0,contentW+40,40);
            [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            [btn setTitle:titStr forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    if (leftBar) {
        [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *barBtn  = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

-(void)setNavBarBgImgWith:(NSString *)imgStr
{
    if ([[[UIDevice currentDevice] systemVersion ]floatValue]<7.0) {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:imgStr] forBarMetrics:UIBarMetricsDefault];
    }else{
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:imgStr] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
}

-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnAction
{
    
}

-(void)bindViewModel
{
}

-(void)bindAction
{
    
}

-(void)buildSubViews
{
    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
