//
//  UIFont+Fonts.h
//  GZCFramework
//
//  Created by ZhongCheng Guo on 2017/7/11.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont(Fonts)

//方便使用的宏定义
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]

/**
 自己添加的字体

 @param size 字号
 @return Font对象
 */
+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size;

/**
 系统自带字体

 @param size 字号
 @return Font对象
 */
+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size;
+ (UIFont *)AvenirWithFontSize:(CGFloat)size;
+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size;
+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size;
+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size;
+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size;

@end
