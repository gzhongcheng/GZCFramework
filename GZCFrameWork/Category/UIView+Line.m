//
//  UIView+Line.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "UIView+Line.h"
#import "GZCConstant.h"

@implementation UIView (Line)


-(CALayer*)drawLineToFrame:(CGRect)frame{
    return [self drawLineToFrame:frame color:mainLineColor];
}

-(CALayer*)drawLineToFrame:(CGRect)frame color:(UIColor*)color{
    CALayer *line = [CALayer layer];
    line.backgroundColor = color.CGColor;
    line.frame = frame;
    [self.layer addSublayer:line];
    return line;
}

@end
