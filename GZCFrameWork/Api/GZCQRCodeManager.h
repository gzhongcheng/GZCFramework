//
//  GZCQRCodeManager.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/9/22.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

// 二维码生成器

#import <UIKit/UIKit.h>

@interface GZCQRCodeManager : NSObject

/**
 创建二维码

 @param source 编码前的内容
 @return 编码后的图像
 */
+ (CIImage *)createQRCodeImage:(NSString *)source;

/**
 调整二维码大小

 @param image 原图
 @param size 目标大小
 @return 缩放后的图片
 */
+ (UIImage *)resizeQRCodeImage:(CIImage *)image
                      withSize:(CGFloat)size;

/**
 二维码上色

 @param image 原图
 @param red 色值
 @param green 色值
 @param blue 色值
 @return 上色后的图片
 */
+ (UIImage *)specialColorImage:(UIImage*)image
                       withRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;

/**
 添加图标

 @param image 原图
 @param icon 图标
 @param iconSize 图标大小
 @return 添加图标后的二维码图片
 */
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image
                         withIcon:(UIImage *)icon
                     withIconSize:(CGSize)iconSize;

/**
 添加图标

 @param image 原图
 @param icon 图标
 @param scale 图标与原图的比例
 @return 添加图标后的二维码图片
 */
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image
                         withIcon:(UIImage *)icon
                        withScale:(CGFloat)scale;

@end
