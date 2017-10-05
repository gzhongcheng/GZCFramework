//
//  UIColor+HexColor.m
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (hexColor)

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


@end
