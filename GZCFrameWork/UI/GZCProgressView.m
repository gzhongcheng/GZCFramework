//
//  GZCProgressView.m
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/2/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCProgressView.h"

@implementation GZCProgressView{
    UIImageView *progressImageView;
    UIImageView *trackImageView;
    UIColor *progressImageColor;
    UIColor *trackImageColor;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        trackImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        trackImageView.layer.cornerRadius = CGRectGetHeight(frame)/2;
        trackImageView.clipsToBounds = YES;
        [self addSubview:trackImageView];
        
        progressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight(frame))];
        progressImageView.layer.cornerRadius = CGRectGetHeight(frame)/2;
        [trackImageView addSubview:progressImageView];
    }
    return self;
}

-(void)setProgress:(float)progress{
    _progress = progress;
    progressImageView.frame = CGRectMake(0, 0, CGRectGetWidth(trackImageView.frame)*progress, CGRectGetHeight(progressImageView.frame));
}

-(void)setProgress:(float)progress animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:.2f animations:^{
            [self setProgress:progress];
        }];
    }else{
        [self setProgress:progress];
    }
}

-(void)setProgressTintColor:(UIColor *)progressTintColor{
    _progressTintColor = progressTintColor;
    progressImageView.backgroundColor = _progressTintColor;
}

-(void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    trackImageView.backgroundColor = _trackTintColor;
}

-(void)setProgressImage:(UIImage *)progressImage{
    _progressImage = progressImage;
    progressImageColor = [UIColor colorWithPatternImage:_progressImage];
    progressImageView.backgroundColor = progressImageColor;
}

-(void)setTrackImage:(UIImage *)trackImage{
    
    _trackImage = trackImage;
    trackImageColor = [UIColor colorWithPatternImage:_trackImage];
    trackImageView.backgroundColor = trackImageColor;
}

@end
