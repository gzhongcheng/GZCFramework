//
//  UIColor+Transformation.m
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/3/1.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIColor+Transformation.h"

@implementation UIColor (Transformation)

+(UIColor *)colorWithTransformationFormColor:(UIColor *)fromColor
                                     toColor:(UIColor *)toColor
                                     percent:(float)percent{
    CGFloat fromRed = 0,fromGreen = 0,fromBlue=0,fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    CGFloat toRed = 0,toGreen = 0,toBlue=0,toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    CGFloat newRed = (toRed-fromRed)*percent+fromRed;
    CGFloat newBlue = (toBlue-fromBlue)*percent +fromBlue;
    CGFloat newGreen = (toGreen-fromGreen)*percent +fromGreen;
    CGFloat newAlpha = (toAlpha -fromAlpha)*percent +fromAlpha;
    UIColor *resultColor = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
    return resultColor;
}

@end
