//
//  UIColor+Transformation.h
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/3/1.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Transformation)

+(UIColor *)colorWithTransformationFormColor:(UIColor*)fromColor
                                     toColor:(UIColor*)toColor
                                     percent:(float)percent;

@end
