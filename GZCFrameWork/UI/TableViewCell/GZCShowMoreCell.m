//
//  GZCShowMoreCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/20.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCShowMoreCell.h"

@implementation GZCShowMoreCell{
    CALayer *leftLine;
    CALayer *rightLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 60)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = BG_COLOR;
        
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, size.width, 20)];
        _placeHolderLabel.textColor = mainFontColor;
        _placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        _placeHolderLabel.text = @"继续拖动，查看图文详情";
        _placeHolderLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_placeHolderLabel];
        
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(size.width/2-15, MaxY(_placeHolderLabel)+self.contentSpace, 30, 30)];
        _arrowImageView.image = [UIImage imageNamed:@"showMore_img"];
        [self.contentView addSubview:_arrowImageView];
        
        leftLine = [self drawLineToFrame:CGRectZero];
        rightLine = [self drawLineToFrame:CGRectZero];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_placeHolderLabel sizeToFit];
    _placeHolderLabel.center = CGPointMake(self.size.width/2, 35);
    leftLine.frame = CGRectMake(30, 35, MinX(_placeHolderLabel)-30-15, 1);
    rightLine.frame = CGRectMake(MaxX(_placeHolderLabel)+15, 35, WIDTH(leftLine), 1);
}

+(float)getHightWithModel:(GZCBaseModel *)model{
    return 60;
}

@end
