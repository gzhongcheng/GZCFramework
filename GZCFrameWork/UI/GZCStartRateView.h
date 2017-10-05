//
//  GZCStartRateView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/10.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  星星评分

#import <UIKit/UIKit.h>

@class GZCStartRateView;
@protocol GZCStartRateViewDelegate <NSObject>
@optional
- (void)starRateView:(GZCStartRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface GZCStartRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;         //得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;            //是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;     //评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL enable;                  //是否可以点击

@property (nonatomic, weak) id<GZCStartRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars;

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
          emptyStartImageName:(NSString*)bgName
           fullStartImageName:(NSString*)fcName;

@end

