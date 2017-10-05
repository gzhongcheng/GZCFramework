//
//  GZCMenuTopView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/8.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCMenuTopView.h"
#import "GZCConstant.h"
#import "UIView+Line.h"

@implementation GZCMenuTopButton{
    UIImage *normalIconImage,*selectedIconImage;
    UIImage *normalDownImage,*selectedDownImage;
    UIColor *normalTitleColor,*selectedTitleColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
        
        _icon_ImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _icon_ImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_icon_ImageView];
        
        _down_ImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _down_ImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_down_ImageView];
        
        normalTitleColor = [UIColor grayColor];
        selectedTitleColor = [UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (normalIconImage==nil) {
        _icon_ImageView.frame = CGRectZero;
    }else{
        _icon_ImageView.frame = CGRectMake(5, HEIGHT(self)/4, HEIGHT(self)/2, HEIGHT(self)/2);
    }
    _titleLabel.center = CGPointMake(WIDTH(self)/2, HEIGHT(self)/2);
    if (normalDownImage==nil) {
        _down_ImageView.frame = CGRectZero;
    }else{
        _down_ImageView.frame = CGRectMake(MaxX(_titleLabel)+5, (HEIGHT(self)-15)/2, 15, 15);
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
}

-(void)setDownImage:(UIImage *)image forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedDownImage = image;
            break;
        default:
            normalDownImage = image;
            _down_ImageView.image = normalDownImage;
            break;
    }
}

-(void)setIconImage:(UIImage *)image forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedIconImage = image;
            break;
        default:
            normalIconImage = image;
            _icon_ImageView.image = normalIconImage;
            break;
    }
}

-(void)setTItleColor:(UIColor *)color forState:(UIControlState)state{
    switch (state) {
        case UIControlStateSelected:
            selectedTitleColor = color;
            break;
        default:
            normalTitleColor = color;
            break;
    }
}

-(void)setSelected:(BOOL)selected{
    [self setSelected:selected changedColor:YES];
}

-(void)setSelected:(BOOL)selected changedColor:(BOOL)changeColor{
    [self setSelected:selected changedColor:changeColor rotated:_shouldRotateWhenSelected];
}

-(void)setSelected:(BOOL)selected changedColor:(BOOL)changeColor rotated:(BOOL)rotated{
    [super setSelected:selected];
    if (changeColor) {
        if (selected) {
            _titleLabel.textColor = selectedTitleColor==nil?normalTitleColor:selectedTitleColor;
            _icon_ImageView.image = selectedIconImage==nil?normalIconImage:selectedIconImage;
            _down_ImageView.image = selectedDownImage==nil?normalDownImage:selectedDownImage;
            if (_shouldRotateWhenSelected) {
                [UIView animateWithDuration:.2f animations:^{
                    _down_ImageView.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            return;
        }
        _titleLabel.textColor = normalTitleColor==nil?[UIColor grayColor]:normalTitleColor;
        _icon_ImageView.image = normalIconImage;
        _down_ImageView.image = normalDownImage;
    }

    if (rotated) {
        [UIView animateWithDuration:.2f animations:^{
            _down_ImageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

@end

@implementation GZCMenuTopView{
    NSMutableArray *lines;
    int tagNumber;
}
@synthesize topLine,bottomLine,buttons;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        buttons = [NSMutableArray array];
        lines = [NSMutableArray array];
        
        self.lineColor = mainLineColor;
        self.showContentLines = YES;
        
        topLine = [self drawLineToFrame:CGRectMake(0, 0, 0, 1)];
        bottomLine = [self drawLineToFrame:CGRectMake(0, 0, 0, 1)];
        tagNumber = 0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    topLine.frame = CGRectMake(0, 0, WIDTH(self), 1);
    topLine.backgroundColor = self.lineColor.CGColor;
    
    bottomLine.frame = CGRectMake(0, HEIGHT(self)-1, WIDTH(self), 1);
    bottomLine.backgroundColor = self.lineColor.CGColor;
    
    float offx = 0;
    float width = WIDTH(self)/[buttons count];
    for (int i = 0; i<[buttons count]; i++) {
        GZCMenuTopButton *btn = buttons[i];
        btn.frame = CGRectMake(offx, 0, width, HEIGHT(self));
        
        offx += width;
        
        if (self.showContentLines&&i<[buttons count]-1) {
            CALayer *line = lines[i];
            line.frame = CGRectMake(offx, 6, 1, HEIGHT(self)-12);
            line.backgroundColor = self.lineColor.CGColor;
        }
    }
}

-(void)addMenuIcon:(NSString *)title{
    [self addMenuIcon:title titleColor:nil selectedTitleColor:nil iconImage:nil iconSelectedImage:nil downImage:nil downSelectedImage:nil shouldRotateWhenSelected:NO];
}

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:selectedTitleColor iconImage:nil iconSelectedImage:nil downImage:nil downSelectedImage:nil shouldRotateWhenSelected:NO];
}

-(void)addMenuIcon:(NSString *)title titleColor:(UIColor *)titleColor iconImage:(UIImage *)iconImage{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:nil iconImage:iconImage iconSelectedImage:nil downImage:nil downSelectedImage:nil shouldRotateWhenSelected:NO];
}

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
         downImage:(UIImage *)downImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected
{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:nil iconImage:nil iconSelectedImage:nil downImage:downImage downSelectedImage:nil shouldRotateWhenSelected:NO];
}

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
         downImage:(UIImage *)downImage
 downSelectedImage:(UIImage *)downSelectedImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected
{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:selectedTitleColor iconImage:nil iconSelectedImage:nil downImage:downImage downSelectedImage:downSelectedImage shouldRotateWhenSelected:shouldRotateWhenSelected];
}

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
         iconImage:(UIImage *)iconImage
 iconSelectedImage:(UIImage *)iconSelectedImage
{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:selectedTitleColor iconImage:iconImage iconSelectedImage:iconSelectedImage downImage:nil downSelectedImage:nil shouldRotateWhenSelected:NO];
}

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
         iconImage:(UIImage *)iconImage
         downImage:(UIImage *)downImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected{
    [self addMenuIcon:title titleColor:titleColor selectedTitleColor:nil iconImage:iconImage iconSelectedImage:nil downImage:downImage downSelectedImage:nil shouldRotateWhenSelected:shouldRotateWhenSelected];
}

-(void)addMenuIcon:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor iconImage:(UIImage *)iconImage iconSelectedImage:(UIImage *)iconSelectedImage downImage:(UIImage *)downImage downSelectedImage:(UIImage *)downSelectedImage shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected{
    GZCMenuTopButton *button = [[GZCMenuTopButton alloc]initWithFrame:CGRectZero];
    button.tag = tagNumber;
    tagNumber++;
    [button setTitle:title];
    if (titleColor) {
        [button setTItleColor:titleColor forState:UIControlStateNormal];
    }
    if (selectedTitleColor) {
        [button setTItleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    [button setDownImage:downImage forState:UIControlStateNormal];
    [button setDownImage:downSelectedImage forState:UIControlStateSelected];
    [button setIconImage:iconImage forState:UIControlStateNormal];
    [button setIconImage:iconSelectedImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
    button.shouldRotateWhenSelected = shouldRotateWhenSelected;
    [self addSubview:button];
    [buttons addObject:button];
    
    CALayer *line = [self drawLineToFrame:CGRectZero];
    [lines addObject:line];
}

-(void)buttonTaped:(GZCMenuTopButton *)btn{
    BOOL shouldChangeColor = YES;
    BOOL shouldRotate = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuTopViewShouldRotate:buttonSelected:atIndex:)]) {
        shouldRotate = [self.delegate GZCMenuTopViewShouldRotate:self buttonSelected:btn atIndex:btn.tag];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuTopViewShouldChangeColor:buttonSelected:atIndex:)]) {
        shouldChangeColor = [self.delegate GZCMenuTopViewShouldChangeColor:self buttonSelected:btn atIndex:btn.tag];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(GZCMenuTopView:buttonSelected:atIndex:)]) {
        [self.delegate GZCMenuTopView:self buttonSelected:btn atIndex:btn.tag];
    }
    for (GZCMenuTopButton *b in buttons) {
        if ([b isEqual:btn]) {
            [b setSelected:!b.selected changedColor:shouldChangeColor rotated:shouldRotate];
        }else{
            [b setSelected:NO changedColor:shouldChangeColor rotated:shouldRotate];
        }
    }
    _selectedIndex = btn.tag;
}

-(void)setSelected:(BOOL)selected toIndex:(NSInteger)index{
    [buttons[index] setSelected:selected];
}

-(void)setTitle:(NSString *)title toIndex:(NSInteger)index{
    GZCMenuTopButton *btn = buttons[index];
    [btn setTitle:title];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    GZCMenuTopButton *btn = buttons[selectedIndex];
    for (GZCMenuTopButton *b in buttons) {
        if ([b isEqual:btn]) {
            [b setSelected:!b.selected];
        }else{
            [b setSelected:NO];
        }
    }
    _selectedIndex = selectedIndex;
}


@end
