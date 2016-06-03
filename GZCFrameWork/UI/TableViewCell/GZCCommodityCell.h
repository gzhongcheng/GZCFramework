//
//  GZCCommodityCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/17.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCCommodityCell : GZCLineTableViewCell

@property (nonatomic, strong) UIImageView * mImageView;      //图片
@property (nonatomic, strong) UILabel * mNameLabel;      //商品名称
@property (nonatomic, strong) UILabel * mPriceLabel;      //价格

@property (nonatomic, strong) CALayer * line;      //分割线

@end
