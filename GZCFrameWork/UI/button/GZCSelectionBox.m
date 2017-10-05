//
//  GZCSelectionBox.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/21.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCSelectionBox.h"
#import "ProjectMacros.h"

#define k_NormalBorderColor [UIColor hexFloatColor:@"abc9c0"]

@interface GZCSelectionBox()


@end

@implementation GZCSelectionBox

-(instancetype)init{
    self = [GZCSelectionBox buttonWithType:UIButtonTypeCustom];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"✓" forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageWithRenderColor:KClearColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    _normalColor = k_NormalBorderColor;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1;
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.titleLabel.font = SYSTEMFONT(self.height*0.9);
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [self setBackgroundImage:[UIImage imageWithRenderColor:selectedColor renderSize:CGSizeMake(1, 1)] forState:UIControlStateSelected];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = _selectedColor.CGColor;
    }else{
        self.layer.borderColor = _normalColor.CGColor;
    }
}

@end
