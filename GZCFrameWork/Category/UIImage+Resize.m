//
//  UIImage+Resize.m
//  MeiJiaXiu
//
//  Created by GuoZhongCheng on 16/2/18.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage(Resize)

- (UIImage *)reSizeToSize:(CGSize)reSize


{
    UIGraphicsBeginImageContextWithOptions(reSize, NO, [[UIScreen mainScreen]scale]);
    
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}
@end
