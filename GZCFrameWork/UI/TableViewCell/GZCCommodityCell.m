//
//  GZCCommodityCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/17.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCCommodityCell.h"

@implementation GZCCommodityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentSpace, 1.2*self.contentSpace, size.height-2.4*self.contentSpace, size.height-2.4*self.contentSpace)];
        _mImageView.layer.cornerRadius = 4.f;
        _mImageView.clipsToBounds = YES;
        _mImageView.backgroundColor = BG_COLOR;
        [self.contentView addSubview:_mImageView];
        
        _mNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxX(_mImageView)+self.contentSpace, MinY(_mImageView), size.width-MaxX(_mImageView)-2*self.contentSpace, 35)];
        _mNameLabel.font = [UIFont systemFontOfSize:14];
        _mNameLabel.textColor = [UIColor blackColor];
        _mNameLabel.numberOfLines = 2;
        _mNameLabel.text = @"名称";
        [self.contentView addSubview:_mNameLabel];
        
        _mPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(MinX(_mNameLabel), size.height-1.5*self.contentSpace -20, WIDTH(_mNameLabel), 20)];
        _mPriceLabel.font = [UIFont systemFontOfSize:13];
        _mPriceLabel.textColor = mainColor;
        _mPriceLabel.text = @"价格";
        [self.contentView addSubview:_mPriceLabel];
        
        _line = [self drawLineToFrame:CGRectMake(self.contentSpace, size.height-1, size.width - 2*self.contentSpace, 1)];
    }
    return self;
}



@end
