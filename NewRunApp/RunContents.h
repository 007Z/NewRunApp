//
//  RunContents.h
//  NewRunApp
//
//  Created by 赵玖录 on 16/9/27.
//  Copyright © 2016年 赵玖录. All rights reserved.
//

#ifndef RunContents_h
#define RunContents_h


//#define  BmapKey @"apakph75IqqCZqo0Cuc3aXPu"
#define  BmapKey @"68gD0TNecarqWxc3qOMTQM1KB856TEK6"
#define  AppKey @"bded1f79115f"
#define  AppSecret @"abf92412b9cc88c90a9ecb00b8298ab0"

#define PushKey @"apakph75IqqCZqo0Cuc3aXPu"
#define PushSecret @"0ZoNTVVKLfh9MH88oWPe7k8EMO4XIK21"


#define ISLOGIN   @"islogin"
#define ISORDER   @"isOrder" //判断是否下单

#define LoginFile  @"LoginFile.plist"
#define OrderFile  @"OrderFile.plist"
#define AddPlist  @"Address.plist"
#define RecorderCAFFile @"RunSound.caf"
#define RecorderMp3File @"RunSound.mp3"

//动画时间
#define AniDur 0.3

//判断系统
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0?YES:NO)

//判断是否是iPhone4
#define isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否是iPhone5
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//是否iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ? CGSizeEqualToSize(CGSizeMake(375*2, 667*2),[[UIScreen mainScreen] nativeBounds].size) : NO)

//是否iPhone6plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(nativeBounds)] ? CGSizeEqualToSize(CGSizeMake(414.000000*3, 736.000000*3),[[UIScreen mainScreen] currentMode].size) : NO)

//frame
#define degreesToRadinas(x) (M_PI * (x)/180.0)//旋转
#define     RESIZE_UI(float)  ((float)/375.0f*SCREEN_WIDTH)

#define SCREEN_HEIGHT              ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0?[[UIScreen mainScreen] bounds].size.height :[[UIScreen mainScreen] bounds].size.height-20)
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width

#define     HEADER_HEIGHT               64
#define     FOOTER_HEIGHT               49

//颜色
#pragma mark - 颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBColor(r,g,b,l) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:l]

#define BLACK_VIEW_COLOR     RGBColor(242, 244, 245, 1)

//字体
#pragma mark - 字体
#define FONT_(size) [UIFont systemFontOfSize:size];
#define FONT_BOLD_(size) [UIFont boldSystemFontOfSize:size]

//手机号码验证
#define TELNUMCHECK(telNum)  \
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(13[0-9]|14[57]|15[012356789]|17[678]|18[012356789])\\d{8}"]  evaluateWithObject:telNum]

#endif /* RunContents_h */
