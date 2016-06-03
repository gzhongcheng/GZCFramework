//
//  GZCMenuLeftCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCMenuLeftCell.h"

@implementation GZCMenuLeftCell{
    CALayer *sLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 40)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, size.width - 15, size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _leftTarget = [self drawLineToFrame:CGRectMake(10, (size.height-13)/2, 3, 13)];
        
        sLine = [self drawLineToFrame:CGRectZero];
        [self setSize:size];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    sLine.backgroundColor = lineColor.CGColor;
}

-(void)setSize:(CGSize)size{
    [super setSize:size];
    _titleLabel.frame = CGRectMake(15, 0, self.size.width - 15, self.size.height);
    sLine.frame = CGRectMake(MinX(_leftTarget),size.height-0.5f, self.size.width-MinX(_leftTarget)*2, 1);
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _leftTarget.hidden = !selected;
    _leftTarget.backgroundColor = self.selctedColor.CGColor;
    if (selected) {
        _titleLabel.textColor = self.selctedColor;
        self.contentView.backgroundColor = self.selctedBgColor;
    }else{
        _titleLabel.textColor = self.normalColor;
        self.contentView.backgroundColor = self.normalBgColor;
    }
}

@end
