//
//  SearchButtonsView.m
//  MeiJiaXiu
//
//  Created by GuoZhongCheng on 16/2/19.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "SearchButtonsView.h"
#import "NSString+Size.h"
#import "GZCFramework.h"

@implementation SearchButtonsView{
    SearchBtnTaped _tapBlock;
}

-(instancetype)initWithFrame:(CGRect)frame icon:(NSString *)iconName title:(NSString *)title items:(NSArray *)items{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self setTitle:title icon:iconName];
        [self setButtons:items];
    }
    return self;
}

- (void)setTitle:(NSString*)title icon:(NSString*)icon{
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
    iconView.image = [UIImage imageNamed:icon];
    [self addSubview:iconView];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+5, CGRectGetMinY(iconView.frame), CGRectGetWidth(self.frame) - CGRectGetMaxX(iconView.frame)-5, 15)];
    titleL.textColor = [UIColor lightGrayColor];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = title;
    [self addSubview:titleL];
}

-(void)setButtons:(NSArray*)items{
    float offX = 20;
    float offY = 25 + 10;
    for (int i=0;i<[items count];i++) {
        NSString *t = items[i];
        UIButton *button = [self getButtonWithTitle:t];
        button.tag = i;
        UIFont *font = [UIFont systemFontOfSize:14];
        button.titleLabel.font = font;
        float width = [t textSizeWithFont:font constrainedToSize:CGSizeMake(CGRectGetWidth(self.frame), 30) lineBreakMode:NSLineBreakByTruncatingMiddle].width;
        if (width<((CGRectGetWidth(self.frame)-80)/3-40)) {
            width = (CGRectGetWidth(self.frame)-80)/3;
        }else{
            width += 40;
        }
        if (offX + width > CGRectGetWidth(self.frame)) {
            offX = 20;
            offY+= 40;
        }
        button.frame = CGRectMake(offX, offY, width, 30);
        offX += 20+width;
        [self addSubview:button];
    }
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), offY+40);
}

-(UIButton*)getButtonWithTitle:(NSString*)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    button.layer.borderColor = [UIColor hexFloatColor:@"e6e6e6"].CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)setBlock:(SearchBtnTaped)taped{
    _tapBlock = taped;
}

-(void)buttonTaped:(UIButton *)sender{
    if (_tapBlock) {
        _tapBlock(sender.titleLabel.text,sender.tag);
    }
    if (_delegate!=nil && [_delegate respondsToSelector:@selector(searchButtonsView:titleDidTaped:atIndex:)]) {
        [_delegate searchButtonsView:self titleDidTaped:sender.titleLabel.text atIndex:sender.tag];
    }
}

@end
