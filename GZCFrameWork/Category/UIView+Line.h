//
//  UIView+Line.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)

//画线，颜色位mainLineColor
-(CALayer*)drawLineToFrame:(CGRect)frame;
//画线
-(CALayer*)drawLineToFrame:(CGRect)frame color:(UIColor*)color;

@end
