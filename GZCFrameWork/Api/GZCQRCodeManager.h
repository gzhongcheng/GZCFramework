//
//  GZCQRCodeManager.h
//  LXJLB
//
//  Created by GuoZhongCheng on 16/9/22.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZCQRCodeManager : NSObject

+ (CIImage *)createQRCodeImage:(NSString *)source;
+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;
+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale;

@end
