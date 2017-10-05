//
//  UIView+AnimationProperty.m
//  AlertViewDemo
//
//  Created by YouXianMing on 15/10/15.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "UIView+AnimationProperty.h"
#import <objc/runtime.h>

@implementation UIView (AnimationProperty)

#pragma mark - Scale.

NSString * const _recognizerScale = @"_recognizerScale";

- (void)setScale:(CGFloat)scale {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerScale), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (CGFloat)scale {
    
    NSNumber *scaleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerScale));
    return scaleValue.floatValue;
}

#pragma mark - Angle.

NSString * const _recognizerAngle = @"_recognizerAngle";

- (void)setAngle:(CGFloat)angle {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerAngle), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (CGFloat)angle {
    
    NSNumber *angleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerAngle));
    return angleValue.floatValue;
}

-(void)appearAnimation{
    self.alpha = 0.97f;
    self.scale = 0.975f;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.f;
        self.scale = 1.f;
    }];
}

-(void)disappearAnimation{
    [UIView animateWithDuration:.75f animations:^{
        self.alpha = 0.f;
        self.scale = 0.975f;
    }];
}

@end
