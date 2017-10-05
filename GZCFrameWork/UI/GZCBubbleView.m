//
//  GZCBubbleView.m
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/3/16.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCBubbleView.h"

@implementation GZCBubbleView

#define GZCTargetPoint      CGPointMake(0,20)
#define GZCPointerSize      10
#define GZCCornerRadius     5
#define GZCBorderWidth      1
#define GZCBorderColor      [UIColor grayColor]
#define GZCBackgroundColor  [UIColor clearColor]
#define GZCConterColor      [UIColor whiteColor]

@synthesize targetPoint,bubbleFrame,pointerSize,cornerRadius,borderColor,borderWidth;

-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame bubbleFrame:CGRectMake(10, 0, CGRectGetWidth(frame)-10, CGRectGetHeight(frame)) targetPoint:GZCTargetPoint pointerSize:GZCPointerSize cornerRadius:GZCCornerRadius];
}

-(instancetype)initWithFrame:(CGRect)frame bubbleFrame:(CGRect)bubbleframe targetPoint:(CGPoint)point pointerSize:(int)size cornerRadius:(int)radius{
    self = [super initWithFrame:frame];
    if (self) {
        targetPoint = point;
        pointerSize = size;
        cornerRadius = radius;
        borderWidth = GZCBorderWidth;
        self.backgroundColor = GZCBackgroundColor;
        self.conterColor = GZCConterColor;
        self.borderColor = GZCBorderColor;
        self.bubbleFrame = bubbleframe;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(c, self.backgroundColor.CGColor);
    CGContextSetLineWidth(c, self.borderWidth);
    //确定画线的宽度，对象组合，颜色
    CGMutablePathRef bubblePath = CGPathCreateMutable();
    //绘制起点－箭头右边－气泡右上顶点－右下顶点－左下顶点－左上顶点－箭头左边－起点闭合
    CGPathMoveToPoint(bubblePath, NULL, targetPoint.x, targetPoint.y);
    CGPathAddArcToPoint(bubblePath, NULL,targetPoint.x, targetPoint.y, targetPoint.x+pointerSize, targetPoint.y-pointerSize/3*2,cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL,targetPoint.x+pointerSize, targetPoint.y-pointerSize/3*2, bubbleFrame.origin.x, bubbleFrame.origin.y,cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL, bubbleFrame.origin.x, bubbleFrame.origin.y,
                      bubbleFrame.origin.x + bubbleFrame.size.width, bubbleFrame.origin.y, cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL, bubbleFrame.origin.x + bubbleFrame.size.width, bubbleFrame.origin.y,
                      bubbleFrame.origin.x+bubbleFrame.size.width, bubbleFrame.origin.y+bubbleFrame.size.height, cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL, bubbleFrame.origin.x+bubbleFrame.size.width, bubbleFrame.origin.y+bubbleFrame.size.height,
                      bubbleFrame.origin.x, bubbleFrame.origin.y+bubbleFrame.size.height, cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL, bubbleFrame.origin.x, bubbleFrame.origin.y+bubbleFrame.size.height,
                      bubbleFrame.origin.x, targetPoint.y+pointerSize , cornerRadius);
    CGPathAddArcToPoint(bubblePath, NULL, targetPoint.x + pointerSize, targetPoint.y+pointerSize/3*2,targetPoint.x, targetPoint.y,cornerRadius);
    CGPathCloseSubpath(bubblePath);

    //绘制阴影
    CGContextAddPath(c, bubblePath);
    CGContextSaveGState(c);
    CGContextSetShadow(c, CGSizeMake(0, 0), 0);
    CGContextSetFillColorWithColor(c, self.conterColor.CGColor);
    CGContextFillPath(c);
    CGContextRestoreGState(c);

    //设置边线颜色
    CGContextAddPath(c, bubblePath);
    CGContextClip(c);

    int numberBorderComponents = (int)CGColorGetNumberOfComponents([borderColor CGColor]);
    const CGFloat *borderComponents = CGColorGetComponents(borderColor.CGColor);
    CGFloat r,g,b,a;
    if (numberBorderComponents == 2) {
      r = borderComponents[0];
      g = borderComponents[0];
      b = borderComponents[0];
      a = borderComponents[1];
    }else {
      r = borderComponents[0];
      g = borderComponents[1];
      b = borderComponents[2];
      a = borderComponents[3];
    }
    CGContextSetRGBStrokeColor(c, r, g, b, a);
    CGContextAddPath(c, bubblePath);
    CGContextDrawPath(c, kCGPathStroke);
    
    CGPathRelease(bubblePath);
}

@end
