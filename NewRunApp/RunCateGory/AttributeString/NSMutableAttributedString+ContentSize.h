//
//  NSMutableAttributedString+ContentSize.h
//  JlParkingApp
//
//  Created by 赵玖录 on 16/9/23.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (ContentSize)

+(NSMutableAttributedString *)addStringAttributed:(NSString *)str font:(UIFont *)font;
+(CGFloat)getContentHeight:(NSMutableAttributedString *)attributedString width:(CGFloat)showWidth;

+(CGFloat)getContentWidth:(NSMutableAttributedString *)attributedString height:(CGFloat)showheight;

+(NSMutableParagraphStyle *)addParagraphStyle:(NSString *)str;
@end
