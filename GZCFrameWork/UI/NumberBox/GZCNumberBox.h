//
//  GZCNumberBox.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/8/29.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZCNumberBox;
@protocol GZCNumberBoxDelegate <NSObject>

@optional
//数字即将改变,返回false则不改变，true则改变
-(BOOL)GZCNumberBox:(GZCNumberBox*)view
   numberWillChange:(int)number;

-(void)GZCNumberBox:(GZCNumberBox*)view
    numberDidChange:(int)number;

@end

@interface GZCNumberBox : UIView

/**
 ┌───┐┌─────┐┌───┐
 │ - ││  0  ││ + │
 └───┘└─────┘└───┘
 */

/**
 边框
 */
@property (nonatomic,assign) float borderWidth;
@property (nonatomic,strong) UIColor *borderColor;

/**
 圆角弧度
 */
@property (nonatomic,assign) float cornerRadius;

/**
 间距
 */
@property (nonatomic,assign) float spacing;

/**
 按钮可点击时的颜色
 */
@property (nonatomic,strong) UIColor *clickableColor;

/**
 最小值，默认1
 */
@property (nonatomic,assign) int minNumber;

/**
 最大值，默认10
 */
@property (nonatomic,assign) int maxNumber;

/**
 显示的数值
 */
@property (nonatomic,assign) int number;

/**
 是否可以直接输入数字
 */
@property (nonatomic,assign) BOOL focuseAble;

/**
 代理
 */
@property (nonatomic,weak) id<GZCNumberBoxDelegate> delegate;

@end
