//
//  GZCNumberChoiceView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/26.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  数字选择

#import <UIKit/UIKit.h>

@class GZCNumberChoiceView;
@protocol GZCNumberChoiceViewDelegate <NSObject>

//数字即将改变,返回false则不改变，true则改变
-(BOOL)GZCNumberChoiceView:(GZCNumberChoiceView*)view
          numberWillChange:(int)number;

@end

@interface GZCNumberChoiceView : UIView

@property (nonatomic, assign) int minNumber;      //最小值，默认1
@property (nonatomic, assign) int maxNumber;      //最大值，默认10
@property (nonatomic, assign) int number;         //显示的数值

@property (nonatomic,weak)   id<GZCNumberChoiceViewDelegate> delegate;

@end
