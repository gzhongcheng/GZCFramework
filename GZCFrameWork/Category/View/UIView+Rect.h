//
//  UIView+Rect.h
//  GZCFramework
//
//  Created by ZhongCheng Guo on 2017/7/11.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//
//  对view的frame的各种值的操作

#import <UIKit/UIKit.h>

@interface UIView(Rect)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

@end
