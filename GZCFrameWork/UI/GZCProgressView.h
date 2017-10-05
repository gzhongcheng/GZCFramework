//
//  GZCProgressView.h
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/2/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//  进度条

#import <UIKit/UIKit.h>

@interface GZCProgressView : UIView

@property(nonatomic) float progress;                        // 0.0 .. 1.0, 默认0
@property(nonatomic, strong, nullable) UIColor* progressTintColor ;
@property(nonatomic, strong, nullable) UIColor* trackTintColor    ;
@property(nonatomic, strong, nullable) UIImage* progressImage     ;
@property(nonatomic, strong, nullable) UIImage* trackImage        ;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
