//
//  GZCSubtitleCell.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/11.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@interface GZCSubtitleCell : GZCLineTableViewCell

@property (nonatomic,strong) UIImageView * myImageView; //系统自带的用sd加载网路图片不会刷新

- (void)setWebImage:(NSString *)imageUrl;

@end
