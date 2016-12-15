//
//  RunMainViewController.m
//  NewRunApp
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.

#import "RunMainViewController.h"
#import "RunLeftView.h"
#import <BMKMapView.h>
#import "RunBottomView.h"
#import "RunPersonViewController.h"
#import "RunLoginViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "RunMicroPhoneView.h"
#import "RunWordOrderView.h"
#import "RunVoiceOrderView.h"
//引入地图功能所有的头文件

@interface RunMainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    //当前定位的经纬度对象
    CLLocationCoordinate2D  coordinate;
}
//左上角按钮
@property(nonatomic,strong)RunLeftView  *leftView;
/**定位*/
@property(nonatomic,strong)BMKLocationService  *locatioService;
//地图
@property(nonatomic,strong)BMKMapView *bMapView;
//底部视图
@property(nonatomic,strong)RunBottomView  *bottomView;
//麦克风
@property(nonatomic,strong)RunMicroPhoneView  *microPhoneView;
//文字订单页面
@property(nonatomic,strong)RunWordOrderView *wordOrderView;
//语音订单页面
@property(nonatomic,strong)RunVoiceOrderView *voiceOrderView;
@end

@implementation RunMainViewController

#pragma --mark  lazy Loading--

-(RunLeftView *)leftView
{
    if (!_leftView) {
        _leftView = [[RunLeftView alloc] initWithFrame:CGRectMake(0, 0,RESIZE_UI(40),RESIZE_UI(40))];
    }
    return _leftView;
}

-(RunMicroPhoneView *)microPhoneView
{
    if (!_microPhoneView) {
        _microPhoneView = [[RunMicroPhoneView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-RESIZE_UI(130))/2, _bMapView.top+(_bMapView.height-RESIZE_UI(130))/2,RESIZE_UI(130),RESIZE_UI(130))];
    }
    return _microPhoneView;
}

-(RunWordOrderView *)wordOrderView
{
    if (!_wordOrderView) {
        _wordOrderView = [[RunWordOrderView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,RESIZE_UI(300))];
    }
    return _wordOrderView;
}

-(RunVoiceOrderView *)voiceOrderView
{
    if (!_voiceOrderView) {
        _voiceOrderView = [[RunVoiceOrderView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,RESIZE_UI(300))];
    }
    
    return _voiceOrderView;
}


-(BMKMapView *)bMapView
{
    if (!_bMapView) {
        _bMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, HEADER_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT-HEADER_HEIGHT-self.bottomView.height)];
        _bMapView.mapType = BMKMapTypeStandard;
        _bMapView.delegate = self;
        _bMapView.zoomLevel = 18;
        _bMapView.userTrackingMode = BMKUserTrackingModeFollow;
        _bMapView.showsUserLocation = YES;
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        displayParam.locationViewImgName= @"icon";//定位图标名称
        displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
        displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
        [_bMapView updateLocationViewWithParam:displayParam];
    }
    return _bMapView;
}

-(RunBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[RunBottomView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-RESIZE_UI(90),SCREEN_WIDTH,RESIZE_UI(90))];
    }
    return _bottomView;
}

-(void)buildSubViews
{
    //添加地图
    [self.view addSubview:self.bMapView];
    
    //底部试图
    [self.view addSubview:self.bottomView];
    
    //添加麦克风
    [self.view addSubview:self.microPhoneView];
    [self.microPhoneView hideMicroPhone];
    
    //添加文字订单
    [self.wordOrderView showInView:self.view];
    //添加语音订单
    [self.voiceOrderView showInView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTit:@"帮您跑个腿" leftImgName:nil leftTitstr:nil rightImgName:@"set_ico" rightTitStr:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftView];
    [self.leftView ReloadRunData];
    
    [self buildSubViews];
    
    //初始化定位服务
    [self initLocation];
    
    [self bindViewModel];
    
    [self bindAction];
   
}

-(void)rightBtnAction
{
    RunPersonViewController  *personVc = [[RunPersonViewController alloc] init];
    [self.navigationController pushViewController:personVc animated:YES];
}

-(void)bindViewModel
{
    //文字订单
    self.wordOrderView.textView.textChangeBlock = ^(id value){
        
    };
}

-(void)bindAction
{
    //文字订单绑定
    @weakify(self);
    self.bottomView.wordOrderBlock = ^{
        
        @strongify(self);
        if (![GolbalManager sharedManager].isLogin) {
            [self pushLoginVc];
        }else{
            
            [self.wordOrderView show];
        }
    };
    
    //语音订单绑定
    self.bottomView.voiceOrderBlock = ^(NSInteger index){
        @strongify(self);
        if (![GolbalManager sharedManager].isLogin) {
            [self pushLoginVc];
        }else{
            
            switch (index) {
                case 1:
                {
                    //上次录音是否存在
                    if ([RunComment isRecorderFileExistwithStrPath:self.microPhoneView.recordCafPath]) {
                        [[RunAlert ShareInstance] ShowAlertWithTitle:@"提示" withMessage:@"是否使用上次录音" withCancelTitle:@"取消" withOtherTitle:@"确定" withAlertCompleteBlock:^(NSInteger index) {
                            
                            self.voiceOrderView.recorderPath = self.microPhoneView.recordMp3Path;
                            self.voiceOrderView.allTime = self.microPhoneView.recordTime;
                            [self.voiceOrderView show];
                            
                        } withAlertCancelBlock:^(NSInteger index) {
                            [self.microPhoneView removeCoderVoice];
                        }];
                    }else{
                        
                        //开始录音
                        [self.microPhoneView showMicroPhone];
                        [self.microPhoneView runStartRecorder];
                    }
                }
                    break;
                case 2:
                {
                    [self.microPhoneView hideMicroPhone];
                    [self.microPhoneView runCancelRecorder];
                    //录音大于1秒时弹出语音下单
                    if (self.microPhoneView.recordTime>1) {
                        
                        [self.voiceOrderView RunStarPLayRecoderWithUrl:self.microPhoneView.recordUrl];
                        self.voiceOrderView.recorderPath = self.microPhoneView.recordMp3Path;
                        self.voiceOrderView.allTime = self.microPhoneView.recordTime;
                        [self.voiceOrderView show];

                    }else{
                        //小于1秒就删除录音不下单
                        [self.microPhoneView removeCoderVoice];
                    }
                }
                    break;
                case 3:
                {
                    [self.microPhoneView hideMicroPhone];
                    [self.microPhoneView runCancelRecorder];
                    [self.microPhoneView removeCoderVoice];
                }
                    break;
                default:
                    break;
            }
        }
    };
    
    //文字地址选择
    [[self.wordOrderView.addressBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
       
    }];
    
    //语音地址选择
    [[self.voiceOrderView.addressBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        
    }];
    
    //文字下单
    [[self.wordOrderView.orderBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
        
    }];
    
    //语音下单
    [[self.voiceOrderView.orderBtn addActionForControlEvents:UIControlEventTouchUpInside] perform:^(id sender) {
        
        @strongify(self);
    }];
}

-(void)initLocation
{
    _locatioService = [[BMKLocationService alloc] init];
    _locatioService.delegate = self;
    _locatioService.distanceFilter = 50.0f;
    [_locatioService startUserLocationService];
    
    [RunComment locationStateCheck];
}

#pragma --LocationServiceDelegate -- mark
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [self.bMapView updateLocationData:userLocation];
    [self removePointAnnoation];
    coordinate.latitude = userLocation.location.coordinate.latitude;
    coordinate.longitude = userLocation.location.coordinate.longitude;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = coordinate;//中心点
    region.span.latitudeDelta = 0.01;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.01;//纬度范围
    [self.bMapView setRegion:region animated:YES];
    self.bMapView.centerCoordinate = userLocation.location.coordinate;
    [self addPointAnnoation];
}

//添加地图标注
-(void)addPointAnnoation
{
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    pointAnnotation.coordinate = coordinate;
    [self.bMapView addAnnotation:pointAnnotation];
    [self.bMapView selectAnnotation:pointAnnotation animated:YES];
}

//删除地图标注
-(void)removePointAnnoation
{
    NSArray *arr = [self.bMapView annotations];
    [self.bMapView removeAnnotations:arr];
}

#pragma --BMKMapView Delegate --mark
//根据添加的annotation生成相应的view
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *Identifier = @"BMKPointAnnotation";
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Identifier];
        annotationView.image = [UIImage imageNamed:@"mark_ico"];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}

//选中当前的标注视图
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
}

//地图区域发生变化
-(void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    _reLocatBtn.hidden = animated;
}

//地图加载完毕
-(void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
}

//跳转登录界面
-(void)pushLoginVc
{
    RunLoginViewController  *loginVc = [[RunLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
