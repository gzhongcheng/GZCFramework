//
//  UIImage+Blur.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/3/3.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//  毛玻璃效果

#import <UIKit/UIKit.h>

@interface UIImage (Blur)


/**
 毛玻璃效果

 @param radius 模糊粒度
 @return 处理后的图片
 */
- (UIImage *)applyBlurRadius:(CGFloat)radius;

@end

@interface UIImage (ImageEffects)


/**
 图片加上白色蒙版并模糊化（模糊粒度30）

 @return 处理后的图片
 */
- (UIImage *)applyLightEffect;

/**
 图片加上白色蒙版并模糊化（模糊粒度20）

 @return 处理后的图片
 */
- (UIImage *)applyExtraLightEffect;

/**
 图片加上灰色蒙版并模糊化 (模糊粒度20)

 @return 处理后的图片
 */
- (UIImage *)applyDarkEffect;

/**
 图片加上指定颜色蒙版并模糊化 (模糊粒度10)

 @param tintColor 蒙版颜色
 @return 处理后的图片
 */
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

/**
 模糊效果

 @param blurRadius 模糊粒度
 @param tintColor 蒙版颜色
 @param saturationDeltaFactor 饱和度
 @param maskImage 裁剪蒙版
 @return 处理后的图片
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

@end
