//
//  UIImage+RenderedImage.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/1/7.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderedImage)

/**
 根据颜色创建图片

 @param color 颜色
 @param size 大小
 @return 创建的图片
 */
+ (UIImage *)imageWithRenderColor:(UIColor *)color
                       renderSize:(CGSize)size;

/**
 根据颜色创建圆角图片

 @param color 颜色
 @param size 大小
 @param radius 圆角半径
 @return 创建的图片
 */
+ (UIImage *)imageWithRenderColor:(UIColor *)color
                       renderSize:(CGSize)size
                           radius:(int)radius;

/**
 根据文字创建图片

 @param text 文字内容
 @param font 字体
 @param color 颜色
 @return 创建的图片
 */
+ (UIImage *)imageFromText:(NSString*)text
                  withFont:(UIFont *)font
                 withColor:(UIColor *)color;

/**
 获取某个点点像素颜色

 @param point 点的坐标
 @return 点的颜色
 */
- (UIColor *)getPixelColorAtLocation:(CGPoint)point;

/**
 根据颜色创建图片 （大小为self的大小）

 @param color 颜色
 @return 新创建的图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
