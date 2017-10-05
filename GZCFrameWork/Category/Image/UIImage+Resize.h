//
//  UIImage+Resize.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/2/18.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

/**
 将图片重绘成指定大小

 @param reSize 指定大小
 @return 重绘后的图片
 */
- (UIImage *)reSizeToSize:(CGSize)reSize;


/**
 将图片重绘成圆角图片

 @param size 大小
 @param radius 圆角半径
 @return 重绘后的图片
 */
- (UIImage *)roundedRectWithSize:(CGSize)size
                      withRadius:(NSInteger)radius;


/**
 将图片绘制成旋转后的图片

 @param orientation UIImageOrientation枚举，旋转方向
 @return 旋转后的图片
 */
- (UIImage *)rotation:(UIImageOrientation)orientation;
@end
