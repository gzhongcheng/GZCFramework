//
//  UIColor+HexColor.h
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

@interface UIColor (hexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr;

@end
