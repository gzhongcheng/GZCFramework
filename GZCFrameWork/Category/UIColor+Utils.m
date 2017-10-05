//
//  UIColor+Utils.m
//  GZCFramework
//
//  Created by GuoZhongCheng on 17/6/3
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "UIColor+Utils.h"
#import "UtilsMacros.h"

@implementation UIColor (Utils)

+ (UIColor *)hexFloatColor:(NSString *)hexStr {
    if (hexStr.length < 6)
        return nil;
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = RGB(red_, green_, blue_);
    return resultColor;
}

+(UIColor *)colorWithTransformationFromColor:(UIColor*)fromColor
                                     toColor:(UIColor *)toColor
                                     percent:(float)percent{
    if (percent >= 1) {
        return toColor;
    }else if (percent <= 0){
        return fromColor;
    }
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

+(UIColor *)colorWithAlpha:(float)alpha fromColor:(UIColor *)fromColor{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat a = 0.0;
    [fromColor getRed:&red green:&green blue:&blue alpha:&a];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

-(UIColor *)changeAlpha:(float)alpha{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat a = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&a];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
    
}

@end
