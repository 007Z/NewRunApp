//
//  NSMutableAttributedString+ContentSize.m
//  JlParkingApp
//
//  Created by 赵玖录 on 16/9/23.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#import "NSMutableAttributedString+ContentSize.h"

@implementation NSMutableAttributedString (ContentSize)

+(NSMutableAttributedString *)addStringAttributed:(NSString *)str font:(UIFont *)font
{
    if ([str isEqualToString:@""] || str == nil) return 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [self addParagraphStyle:str];
    NSDictionary *dic = @{NSParagraphStyleAttributeName : paragraphStyle,
                          NSFontAttributeName : font,
                          };
    [attributedString addAttributes:dic range:NSMakeRange(0,[str length])];
    
    return attributedString;
}

+(CGFloat)getContentHeight:(NSMutableAttributedString *)attributedString width:(CGFloat)showWidth
{
    if (attributedString.length>0) {
        NSRange range = NSMakeRange(0, attributedString.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];
        CGSize size = [attributedString.mutableString boundingRectWithSize:CGSizeMake(showWidth, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        return size.height;
    }
    
    return 0;
}

+(CGFloat)getContentWidth:(NSMutableAttributedString *)attributedString height:(CGFloat)showheight
{
    if (attributedString.length>0) {
        NSRange range = NSMakeRange(0, attributedString.length);
        NSDictionary *attributes = [attributedString attributesAtIndex:0 effectiveRange:&range];
        CGSize size = [attributedString.mutableString boundingRectWithSize:CGSizeMake(0, showheight) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        return size.width;
    }
    return 0;
}

+(NSMutableParagraphStyle *)addParagraphStyle:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = RESIZE_UI(6); // 字体的行间距
    paragraphStyle.firstLineHeadIndent = 0.0f; //首行缩进
    paragraphStyle.paragraphSpacing = RESIZE_UI(6); //段与段之间的间距
    paragraphStyle.headIndent = 0;//整体缩进(首行除外)
    paragraphStyle.tailIndent = 0;//
    //    paragraphStyle.minimumLineHeight = 20;//最低行高
    //    paragraphStyle.maximumLineHeight = 30;//最大行高
    
    paragraphStyle.hyphenationFactor = 0;//连字属性
    [paragraphStyle setAlignment:NSTextAlignmentJustified];
    return paragraphStyle;
}

@end
