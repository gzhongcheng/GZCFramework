//
//  GZCIconTextCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/15.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCIconTextCell : GZCLineTableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;      //图标
@property (nonatomic, assign) CGSize iconSize;      //图标大小,默认20*20

@property (nonatomic, strong) UILabel * titleLabel;      //标题
@property (nonatomic, strong) UILabel * subTitleLabel;      //右侧子标题

@property (nonatomic, strong) UIColor * titleColor;      //标题颜色，默认黑色
@property (nonatomic, strong) UIColor * subTitleColor;      //子标题颜色，默认灰色

@property (nonatomic, assign) BOOL showsArrow;      //是否显示右侧箭头，默认显示

@property (nonatomic, assign) CGFloat marginHorizontal;      //左右两侧的空白，默认10

@property (nonatomic, strong) CALayer * line;      //底部横线

@end
