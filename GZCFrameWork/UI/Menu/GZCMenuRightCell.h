//
//  GZCMenuRightCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/9.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCMenuRightCell : GZCLineTableViewCell

@property (nonatomic, strong) UIColor * selctedColor;      //选中颜色
@property (nonatomic, strong) UIColor * normalColor;      //未选中颜色

@property (nonatomic, strong) UIColor * selctedBgColor;      //选中背景颜色
@property (nonatomic, strong) UIColor * normalBgColor;      //未选中背景颜色

@property (nonatomic, strong) UIColor * lineColor;      //分割线颜色

@property (nonatomic, strong) UILabel * titleLabel;      //标题

@end
