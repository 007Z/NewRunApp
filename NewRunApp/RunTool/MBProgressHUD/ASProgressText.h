//
//  ASProgressText.h
//  ishangzu
//
//  Created by ishangzuIOS on 16/2/22.
//  Copyright © 2016年 耿用强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    /** 文字图片都有*/
    ASProgressTextModeAll,
    /** 只有图片 */
    ASProgressTextModeImage,
    /** 只有文字 */
    ASProgressTextModeText
    
} ASProgressTextMode;

@interface ASProgressText : UIView

#pragma mark - property
//背景颜色
@property (nonatomic,strong) UIColor *blackGroundColor;
//文字颜色
@property (nonatomic,strong) UIColor *messageColor;
//圆角
@property (nonatomic,assign) CGFloat cornerRadius;
//透明度
@property (nonatomic,assign) CGFloat alpha;
//font
@property (nonatomic,assign) CGFloat font;
//frame
@property (nonatomic,assign) CGRect textViewRect;

@property (nonatomic,assign) BOOL onTouch;

@property (nonatomic,strong,readonly) UIImage *messageImage;
@property (nonatomic,assign,readonly) ASProgressTextMode progressMode;
#pragma mark - views
@property (nonatomic,strong) UIView* blackGroundView;
@property (nonatomic,strong) UILabel* textLabel;
@property (nonatomic,strong) UIImageView* imageView;



#pragma mark - init method
- (instancetype)initWithMessgae:(NSString*)message withView:(UIView*)view;
- (instancetype)initWithImage:(UIImage*)image withView:(UIView*)view;
- (instancetype)initWithMessgae:(NSString *)message withImage:(UIImage*)image withView:(UIView *)view;

#pragma mark - show method
- (void)showAnimation;
- (void)hideAnimation;
- (void)hide:(CGFloat)delay;
@end
