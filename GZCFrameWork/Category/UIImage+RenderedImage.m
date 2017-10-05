//
//  UIImage+RenderedImage.m
//  Shop
//
//  Created by GuoZhongCheng on 16/1/7.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIImage+RenderedImage.h"

@implementation UIImage (RenderedImage)
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    [color setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0., 0., size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size radius:(int)radius{
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    float fw = size.width;
    float fh = size.height;
    CGContextMoveToPoint(context, fw, radius);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-radius, fh, radius);  // 右下角角度
    CGContextAddArcToPoint(context, 0, fh, 0, fh-radius, radius); // 左下角角度
    CGContextAddArcToPoint(context, 0, 0, fw-radius , 0, radius); // 左上角
    CGContextAddArcToPoint(context, fw, 0, fw,fh- radius, radius); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
