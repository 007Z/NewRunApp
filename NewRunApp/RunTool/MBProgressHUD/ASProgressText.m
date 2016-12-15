//
//  ASProgressText.m
//  ishangzu
//
//  Created by ishangzuIOS on 16/2/22.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import "ASProgressText.h"
#import "NSMutableAttributedString+ContentSize.h"

@implementation ASProgressText
{
    NSString*_message;
    
}


- (void)initDefaultData{
    _blackGroundColor = RGBColor(0, 0, 0, 0.6);
    _cornerRadius = 6;
    _alpha = 1;
    _font = 14.0;
    _messageColor = [UIColor whiteColor];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

}


- (instancetype)initWithMessgae:(NSString *)message withView:(UIView *)view{
    self = [super init];
    if (self) {
        [self initDefaultData];
        _message = message;
        _progressMode = ASProgressTextModeText;
        [self buildMessageView:view];
    }

    return self;
}



- (instancetype)initWithImage:(UIImage *)image withView:(UIView *)view{
    self = [super init];
    if (self) {
        [self initDefaultData];
        _messageImage = image;
        _progressMode = ASProgressTextModeImage;
        [self buildMessageView:view];
    }
    return self;
}


- (instancetype)initWithMessgae:(NSString *)message withImage:(UIImage *)image withView:(UIView *)view{
    self = [super init];
    if (self) {
        [self initDefaultData];
        _message = message;
        _messageImage = image;
        _progressMode = ASProgressTextModeAll;
        [self buildMessageView:view];
        
    }
    return self;
}

- (void)buildMessageView:(UIView*)view{
    
    _blackGroundView = [[UIView alloc]init];
    _textLabel = [[UILabel alloc]init];
    [_blackGroundView addSubview:_textLabel];

    if (_messageImage) {
        _blackGroundView.frame = CGRectMake((SCREEN_WIDTH-100)/2, (SCREEN_HEIGHT-100)/2,100,100);
        _imageView = [[UIImageView alloc] initWithImage:_messageImage];
        _imageView.frame = CGRectMake((_blackGroundView.width-80/2)/2,(_blackGroundView.height-80/2)/2-10,80/2,80/2);
        _textLabel.frame = CGRectMake(RESIZE_UI(25/2),_imageView.frame.origin.y+_imageView.frame.size.height+5,_blackGroundView.width-RESIZE_UI(25), 21);
        [_blackGroundView addSubview:_imageView];
        _cornerRadius = 11;
        _blackGroundColor = RGBColor(47, 47, 54, 1);
        _font = 12;

    }else{
        
        _blackGroundView.frame = CGRectMake((SCREEN_WIDTH-[self messageWidth])/2, (SCREEN_HEIGHT-RESIZE_UI(80/2))/2, [self messageWidth], RESIZE_UI(80/2));
        _textLabel.frame = CGRectMake(RESIZE_UI(25/2), RESIZE_UI(25/2), _blackGroundView.width-RESIZE_UI(25), _blackGroundView.height - RESIZE_UI(25));
    }
    
    _blackGroundView.alpha = 1;
    _blackGroundView.layer.opacity = 0;
    _blackGroundView.backgroundColor = _blackGroundColor;
    [self addSubview:_blackGroundView];
    [self setAllCorner];
    
    _textLabel.textColor = _messageColor;
    _textLabel.text = _message;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont systemFontOfSize:_font];
    
    if (view == nil) {
        if (_onTouch) {
            [[UIApplication sharedApplication].keyWindow addSubview:_blackGroundView];
        }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        
    }else{
        if (_onTouch) {
            [view addSubview:_blackGroundView];
        }else{
            [view addSubview:self];
        }
    }
}

- (CGFloat)messageWidth{
    
    CGFloat  contentW = [NSMutableAttributedString getContentWidth:[[NSMutableAttributedString alloc] initWithString:_message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_font]}] height:RESIZE_UI(80/2)];
    return contentW+28;
}

- (void)showAnimation{
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.3];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.3f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.3f;
    animationGroup.autoreverses = false;   //是否重播，原动画的倒播
    animationGroup.repeatCount = 1;//
    animationGroup.delegate = self;
    //设置动画执行完毕之后不删除动画
    animationGroup.removedOnCompletion=NO;
    //设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    [animationGroup setAnimations:[NSArray arrayWithObjects:opacityAnimation, scaleAnimation, nil]];
    [animationGroup setValue:@"groupAnimation" forKey:@"animationName"];
    [_blackGroundView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag){
        
        NSString *animationName = [anim valueForKey:@"animationName"];
        if ([animationName isEqualToString:@"groupAnimation"])
        {
//            _blackGroundView.alpha = 1.0;
        }else{
            [_blackGroundView.layer removeAllAnimations];
            [self removeFromSuperview];
        }
    }
}


- (void)hide:(CGFloat)delay{
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:delay];
}

- (void)hideAnimation{
    
    
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 0.4;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.4;
    animationGroup.autoreverses = false;   //是否重播，原动画的倒播
    animationGroup.repeatCount = 0;//
    animationGroup.delegate =self;
    animationGroup.removedOnCompletion=NO;
    //设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    [animationGroup setAnimations:[NSArray arrayWithObjects:opacityAnimation, scaleAnimation, nil]];
    [animationGroup setValue:@"removegroupAnimation" forKey:@"animationName"];
    [_blackGroundView.layer addAnimation:animationGroup forKey:@"removegroupAnimation"];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        [self removeFromSuperview];
    }
}



- (void)setAllCorner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_blackGroundView.bounds
                                          cornerRadius:_cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    _blackGroundView.layer.mask = maskLayer;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


}
@end
