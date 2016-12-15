//
//  RunPersonViewController.m
//  NewRunApp
//  Created by 赵玖录 on 16/10/13.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunPersonViewController.h"
#import "RunPerSonViewModel.h"
#import "RunPerSonCell.h"
#import "RunPersonHeadView.h"
#import "RunFooterView.h"
#import "RunLoginViewController.h"
#import "RunSetPwdViewController.h"
#import "RunSetNameViewController.h"
#import "RSKImageCropViewController.h"
#import "RunAddressManagerVc.h"

@interface RunPersonViewController ()<UITableViewDelegate,UITableViewDataSource,RSKImageCropViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)RunPerSonViewModel  *perViewModel;

@property(nonatomic,strong)RunPersonHeadView  *headerView;

@property(nonatomic,strong)RunFooterView  *footerView;

@property(nonatomic,strong)UIImagePickerController *runImgPicker;

@end
@implementation RunPersonViewController

#pragma --mark lazy Loading--

-(RunPerSonViewModel *)perViewModel
{
    if (!_perViewModel) {
        _perViewModel = [[RunPerSonViewModel alloc] init];
    }
    return _perViewModel;
}

-(RunPersonHeadView *)headerView
{
    if (!_headerView) {
        _headerView = [[RunPersonHeadView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,RESIZE_UI(180))];
    }
    
    return _headerView;
}

-(RunFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[RunFooterView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,RESIZE_UI(140))];
    }
    return _footerView;
}

-(UIImagePickerController *)runImgPicker
{
    if (!_runImgPicker) {
        _runImgPicker = [[UIImagePickerController alloc] init];
        _runImgPicker.delegate = self;
    }
    return _runImgPicker;
}

-(void)buildSubViews
{
    [self buildTableView:CGRectMake(0,HEADER_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT) withHeaderView:self.headerView withFooterView:self.footerView andAlwaysBounceVertical:YES Delegate:self DataSouce:self sytle:UITableViewStylePlain];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"个人资料" leftImgName:@"back_ico" leftTitstr:nil rightImgName:nil rightTitStr:nil];
    
    [self buildSubViews];
    
    [self bindViewModel];
    
    [self bindAction];
}

-(void)bindViewModel
{
    [self.headerView reloadPerSonData];
}

-(void)bindAction
{
    @weakify(self);
    //更换头像
    [[self.headerView.carmerBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        if ([GolbalManager sharedManager].isLogin) {
            
            [self seleUserHeadImgAction];
            
        }else{
            
            [self pushLoginVc];
        }
    }];
    
    //退出登录
    [[self.footerView.loginOutBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
    }];
}

#pragma mark - UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.perViewModel.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*settingCell=@"RunPerSonCell";
    RunPerSonCell *cell=[tableView dequeueReusableCellWithIdentifier:settingCell];
    if (cell==nil) {
        cell=[[RunPerSonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
    }
    [cell showInfo:[self.perViewModel.dataSource objectAtIndex:indexPath.row] andIndex:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RESIZE_UI(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            //手机号
            break;
        case 1:
            //设置昵称
        {
            if ([GolbalManager sharedManager].isLogin) {
                RunSetNameViewController *setNameVc = [[RunSetNameViewController alloc] init];
                [self.navigationController pushViewController:setNameVc animated:YES];
                
            }else{
                [self pushLoginVc];
            }
        }
            break;
        case 2:
            //修改密码
        {
            if ([GolbalManager sharedManager].isLogin) {
                RunSetPwdViewController *setPwdVc = [[RunSetPwdViewController alloc] init];
                [self.navigationController pushViewController:setPwdVc animated:YES];
            }else{
                [self pushLoginVc];
            }
        }
            break;
        case 3:
            //默认地址
        {
            if ([GolbalManager sharedManager].isLogin) {
                RunAddressManagerVc  *addressVc = [[RunAddressManagerVc alloc] init];
                [self.navigationController pushViewController:addressVc animated:YES];
            }else{
                [self pushLoginVc];
            }
        }
            break;
        default:
            break;
    }
}

-(void)pushLoginVc
{
    RunLoginViewController  *loginVc = [[RunLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

-(void)seleUserHeadImgAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"从手机相册选择",nil];
    [sheet showInView:self.view];
}

#pragma --mark UIActionSheetDelegate--
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //相机
            self.runImgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.runImgPicker animated:YES completion:nil];
            break;

        case 1:
            //相册
             self.runImgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.runImgPicker animated:YES completion:nil];
            break;
        default:
            return;
            break;
    }
}

#pragma --mark UIImagePickerControllerDeelegate--
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.runImgPicker dismissViewControllerAnimated:YES completion:nil];
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
}

#pragma mark - RSKImageCropViewControllerDelegate
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    [self.navigationController popViewControllerAnimated:YES];
    self.headerView.userImg = [RunComment imageWithImage:croppedImage scaleTosize:CGSizeMake(100, 100)];
}

@end
