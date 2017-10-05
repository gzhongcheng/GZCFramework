//
//  SVPullToRefreshLoadingView.h
//  tenric
//
//  Created by tenric on 15/12/24.
//  Copyright © 2015年 tenric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"

@interface SVPullToRefreshLoadingView : UIView

@property (nonatomic, strong) CAShapeLayer *backCircleLayer;
@property (nonatomic, strong) CAShapeLayer *frontCircleLayer;
@property (nonatomic, strong) CAShapeLayer *pieLayer;
@property (nonatomic, strong) CALayer *circleLayer;
@property (nonatomic, strong) CALayer *lineLayer;
@property (nonatomic, strong) UILabel * titleLabel;      //提示文字

- (void)startLoading;

- (void)stopLoading;

- (void)updateTriggerWithPercent:(CGFloat)percent state:(SVPullToRefreshState)state;

@end
