//
//  ASProgressHUD.m
//  ishangzu
//
//  Created by 赵玖录 on 16/3/6.
//  Copyright © 2016年 耿用强. All rights reserved.
//
#import "ASProgressHUD.h"
#import "UIView+Blurs.h"

@interface ASProgressHUD ()
@property(nonatomic,strong)UIImageView  *imgHUD;
@property(nonatomic,strong)UIView  *subView;
@end

@implementation ASProgressHUD

-(id)initWithView:(UIView *)view
{
    if (view == nil) {
        return [self initWithFrame:CGRectZero];
    }
    return [self initWithFrame:view.bounds];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        [self setAllCorner];
    }
    return self;
}
-(void)initSubViews
{
    self.backgroundColor = [UIColor clearColor];
    _subView = [[UIView alloc] initWithFrame:CGRectMake((self.width-RESIZE_UI(94))/2,(self.height-RESIZE_UI(94))/2,RESIZE_UI(94), RESIZE_UI(94))];
    _subView.backgroundColor = RGBColor(255, 255, 255,0.8);
    [self addSubview:_subView];
    _imgHUD = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-RESIZE_UI(75))/2, (self.height-RESIZE_UI(75))/2,RESIZE_UI(75), RESIZE_UI(75))];
    [self addSubview:_imgHUD];
    NSMutableArray  *imgArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger index = 1; index<34; index++) {
        NSString  *imgName = [NSString stringWithFormat:@"%ld.png",(long)index];
        UIImage  *img = [UIImage imageNamed:imgName];
        [imgArr addObject:img];
    }
    if (imgArr.count>0) {
        _imgHUD.image = [imgArr firstObject];
    }
    [_subView viewBlur];
    _imgHUD.animationImages = imgArr;
    _imgHUD.animationDuration = 1;
    _imgHUD.animationRepeatCount = 0;
}
- (void)setAllCorner {
    _subView.layer.cornerRadius = 15;
    _subView.layer.borderColor = RGBColor(211,211,211,0.4).CGColor;
    _subView.layer.borderWidth = 1;
    _subView.clipsToBounds = YES;
}

-(void)hide:(BOOL)isHide
{
    if (isHide) {
        
        typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            weakSelf.subView.alpha = 0;
            weakSelf.imgHUD.alpha = 0;
            if (weakSelf.imgHUD.isAnimating) {
                [weakSelf.imgHUD stopAnimating];
            }
            [weakSelf.imgHUD viewUnBlur];
            weakSelf.hidden = YES;
        }];
    }
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    /*
    CAKeyframeAnimation  *animat = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animat.duration = 0.3;
    NSMutableArray  *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5,2.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1.0)]];
    animat.values = values;
    [_subView.layer addAnimation:animat forKey:nil];
    [_imgHUD.layer addAnimation:animat forKey:nil];
     */
    CABasicAnimation  *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.duration = 0.2;
    ani.repeatCount = 1;
    ani.autoreverses = NO;
    ani.fromValue = [NSNumber numberWithFloat:1.5];
    ani.toValue = [NSNumber numberWithFloat:1];
    [self.subView.layer addAnimation:ani forKey:@"scale_layer"];
    [self.imgHUD.layer addAnimation:ani forKey:@"scale_layer"];
    if (!self.imgHUD.isAnimating) {
        [self.imgHUD startAnimating];
    }
}
+ (NSArray *)allHUDsForView:(UIView *)view {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:self]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}



@end
