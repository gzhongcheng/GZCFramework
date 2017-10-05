//
//  GZCTextIconView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/17.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCTextIconView.h"
#import "GZCFramework.h"

@implementation GZCTextIconView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text bgColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = color;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:HEIGHT(self)-4];
        self.layer.cornerRadius = 0.12f*HEIGHT(self);
        self.clipsToBounds = YES;
    }
    return self;
}

@end
