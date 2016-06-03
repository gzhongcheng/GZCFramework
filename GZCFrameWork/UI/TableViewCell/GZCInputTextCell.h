//
//  GZCInputTextCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/29.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCInputTextCell : GZCLineTableViewCell

@property (nonatomic, assign) float placeWidth;      //提示文字宽度

@property (nonatomic, strong) UILabel * placeLabel;      //提示文字

@property (nonatomic, strong) UITextField * inputTextField;      //输入框

@end
