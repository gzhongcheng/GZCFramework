//
//  GZCMenuRightCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCMenuRightCell.h"

@implementation GZCMenuRightCell{
    CALayer *sLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.size.width - 15, self.size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        sLine = [self drawLineToFrame:CGRectZero];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(15, 0, self.size.width - 15, self.size.height);
    sLine.frame = CGRectMake(MinX(_titleLabel), HEIGHT(self.contentView)-1, self.size.width-MinX(_titleLabel)*2, 1);
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _titleLabel.textColor = self.selctedColor;
        self.contentView.backgroundColor = self.selctedBgColor;
    }else{
        _titleLabel.textColor = self.normalColor;
        self.contentView.backgroundColor = self.normalBgColor;
    }
}


@end
