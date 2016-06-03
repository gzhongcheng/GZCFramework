//
//  SVPullToRefreshLoadingView.m
//  tenric
//
//  Created by tenric on 15/12/24.
//  Copyright © 2015年 tenric. All rights reserved.
//

#import "SVPullToRefreshLoadingView.h"

@implementation SVPullToRefreshLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage* frontCircleImage = [UIImage imageNamed:@"circle.png"];
        UIImage* backCircleImage = [UIImage imageNamed:@"loading.png"];
        
        _backCircleLayer = [CAShapeLayer layer];
        _frontCircleLayer = [CAShapeLayer layer];
        _pieLayer = [CAShapeLayer layer];
        _circleLayer = [CALayer layer];
        _lineLayer = [CALayer layer];
        
        [self.layer addSublayer:_backCircleLayer];
        [self.layer addSublayer:_frontCircleLayer];
        [self.layer addSublayer:_pieLayer];
        [self.layer addSublayer:_circleLayer];
        [self.layer addSublayer:_lineLayer];
        
        self.backCircleLayer.contents = (__bridge id)[backCircleImage CGImage];
        self.frontCircleLayer.contents = (__bridge id)[frontCircleImage CGImage];
        self.frontCircleLayer.mask = _pieLayer;
        self.circleLayer.contents = (__bridge id _Nullable)(backCircleImage.CGImage);
        self.lineLayer.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        self.lineLayer.anchorPoint = CGPointMake(0, 0);
        
        self.circleLayer.hidden = YES;
        self.lineLayer.hidden = YES;
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 20)];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = CGRectMake((self.bounds.size.width-30)/2, (60-30)/2, 30, 30);
    self.backCircleLayer.frame = frame;
    self.frontCircleLayer.frame = frame;
    self.pieLayer.frame = CGRectMake(0, 0, 30, 30);;
    self.circleLayer.frame = frame;
    self.lineLayer.frame = CGRectMake(self.bounds.size.width/2, (60-30)/2+30-1, 0, 1);
}

- (void)startLoading
{
    [self updateTriggerWithPercent:1 state:SVPullToRefreshStateLoading];
    
    self.frontCircleLayer.hidden = YES;
    self.backCircleLayer.hidden = YES;
    self.pieLayer.hidden = YES;
    self.circleLayer.hidden = NO;
    self.lineLayer.hidden = NO;
    
    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.duration = 1.0;
    rotateAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotateAnimation.repeatCount = HUGE_VAL;
    [self.circleLayer addAnimation:rotateAnimation forKey:@"rotationAnimation"];
    
    CABasicAnimation* widthAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    widthAnimation.duration = 1.0;
    widthAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(self.center.x, self.bounds.size.height-1, 0, 1)];
    widthAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.center.x, self.bounds.size.height-1, 20, 1)];
    widthAnimation.repeatCount = HUGE_VAL;
    [self.lineLayer addAnimation:widthAnimation forKey:@"widthAnimation"];
}

- (void)stopLoading
{
    self.circleLayer.hidden = YES;
    [self.circleLayer removeAnimationForKey:@"rotationAnimation"];
    
    self.lineLayer.hidden = YES;
    [self.lineLayer removeAnimationForKey:@"widthAnimation"];
    
    [self updatePie:self.pieLayer forAngle:0];
    self.frontCircleLayer.mask = self.pieLayer;
}

- (void)updateTriggerWithPercent:(CGFloat)percent state:(SVPullToRefreshState)state
{
    if (percent > 0 && state == SVPullToRefreshStateStopped) {
        self.frontCircleLayer.hidden = NO;
        self.backCircleLayer.hidden = NO;
        self.pieLayer.hidden = NO;
    }
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    [self updatePie:self.pieLayer forAngle:percent * 360.0f];
    self.frontCircleLayer.mask = self.pieLayer;
    
    [CATransaction commit];
}

- (void)updatePie:(CAShapeLayer *)layer forAngle:(CGFloat)degrees
{
    CGFloat angle = -90 * (M_PI / 180.0);
    CGPoint center_ = CGPointMake(CGRectGetWidth(layer.frame)/2.0, CGRectGetHeight(layer.frame)/2.0);
    CGFloat radius = CGRectGetWidth(layer.frame)/2.0;
    
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center_];
    [piePath addLineToPoint:CGPointMake(center_.x, center_.y - radius)];
    [piePath addArcWithCenter:center_ radius:radius startAngle:angle endAngle:(degrees - 90.0f) * (M_PI / 180.0) clockwise:YES];
    [piePath addLineToPoint:center_];
    [piePath closePath];
    
    layer.path = piePath.CGPath;
}

@end
