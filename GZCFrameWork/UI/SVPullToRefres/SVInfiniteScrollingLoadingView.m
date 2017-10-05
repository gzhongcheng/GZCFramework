//
//  SVInfiniteScrollingLoadingView.m
//  tenric
//
//  Created by tenric on 15/12/24.
//  Copyright © 2015年 tenric. All rights reserved.
//

#import "SVInfiniteScrollingLoadingView.h"

@implementation SVInfiniteScrollingLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage* backCircleImage = [UIImage imageNamed:@"loading.png"];
        
        _circlrLayer = [CALayer layer];
        _circlrLayer.contents = (__bridge id _Nullable)(backCircleImage.CGImage);
        
        _lineLayer = [CALayer layer];
        _lineLayer.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        _lineLayer.anchorPoint = CGPointMake(0, 0);
        
        [self.layer addSublayer:_circlrLayer];
        [self.layer addSublayer:_lineLayer];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = CGRectMake((self.bounds.size.width-30)/2, (60-30)/2, 30, 30);
    self.circlrLayer.frame = frame;
    self.lineLayer.frame = CGRectMake(self.bounds.size.width/2, (60-30)/2+30-1, 0, 1);
}

- (void)startLoading
{
    CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.duration = 1.0;
    rotateAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotateAnimation.repeatCount = HUGE_VAL;
    [_circlrLayer addAnimation:rotateAnimation forKey:@"rotationAnimation"];
    _circlrLayer.hidden = NO;
    
    CABasicAnimation* widthAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    widthAnimation.duration = 1.0;
    widthAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(self.center.x, self.bounds.size.height-1, 0, 1)];
    widthAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.center.x, self.bounds.size.height-1, 20, 1)];
    
    widthAnimation.repeatCount = HUGE_VAL;
    [_lineLayer addAnimation:widthAnimation forKey:@"widthAnimation"];
    _lineLayer.hidden = NO;
}

- (void)stopLoading
{
    [_circlrLayer removeAnimationForKey:@"rotationAnimation"];
    _circlrLayer.hidden = YES;
    
    [_lineLayer removeAnimationForKey:@"widthAnimation"];
    _lineLayer.hidden = YES;
}

@end
