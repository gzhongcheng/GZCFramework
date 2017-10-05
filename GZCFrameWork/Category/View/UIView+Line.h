//
//  UIView+Line.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)

/**
 画线，颜色为mainLineColor

 @param frame 绘制位置
 @return 绘制完成后的线条Layer
 */
-(CALayer*)drawLineToFrame:(CGRect)frame;


/**
 画线

 @param frame 绘制位置
 @param color 线条颜色
 @return 绘制完成后的线条Layer
 */
-(CALayer*)drawLineToFrame:(CGRect)frame
                     color:(UIColor*)color;

/**
 画虚线

 @param lineView 需要绘制成虚线的view
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor;

/**
 画线性渐变颜色

 @param path 绘制路径
 @param startPoint 渐变起始位置
 @param startColor 起始颜色
 @param endPoint 渐变结束位置
 @param endColor 结束颜色
 */
- (void)drawLinearGradientPath:(CGPathRef)path
                    startPoint:(CGPoint)startPoint
                    startColor:(CGColorRef)startColor
                      endPoint:(CGPoint)endPoint
                      endColor:(CGColorRef)endColor;

/**
 画圆形渐变颜色

 @param path 绘制路径
 @param center 渐变起始位置(圆心)
 @param radius 渐变半径
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)drawRadialGradientPath:(CGPathRef)path
                        center:(CGPoint)center
                        radius:(CGFloat)radius
                    startColor:(CGColorRef)startColor
                      endColor:(CGColorRef)endColor;

@end
