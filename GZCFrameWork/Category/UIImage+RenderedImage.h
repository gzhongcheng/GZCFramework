//
//  UIImage+RenderedImage.h
//  Shop
//
//  Created by GuoZhongCheng on 16/1/7.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderedImage)

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size radius:(int)radius;
@end
