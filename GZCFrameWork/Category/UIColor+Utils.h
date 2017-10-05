//
//  UIColor+Utils.h
//  GZCFramework
//
//  Created by GuoZhongCheng on 17/6/3
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

/**
 根据字符串初始化颜色

 @param hexStr 颜色字符串，格式如 @"ffffff" ==>白色
 @return 转换后的UIColor
 */
+ (UIColor *)hexFloatColor:(NSString *)hexStr;

/**
 根据百分比，获取fromColor变色到toColor的中间色
 
 @param fromColor 起始颜色
 @param toColor 结束颜色
 @param percent 百分比 范围为0.f～1.f
 @return 中间色
 */
+(UIColor *)colorWithTransformationFromColor:(UIColor*)fromColor
                                     toColor:(UIColor*)toColor
                                     percent:(float)percent;

/**
 改变颜色的透明度

 @param alpha 透明度
 @param fromColor 颜色
 @return 改变后的UIColor
 */
//+ (UIColor *)colorWithAlpha:(float)alpha
//                  fromColor:(UIColor *)fromColor;
//- (UIColor *)changeAlpha:(float)alpha;

/****** 请使用系统方法 [self colorWithAlphaComponent:alpha]; *****/

@end
