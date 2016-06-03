//
//  GZCCityHotCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/28.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCCityHotCell.h"

#define DEFORTARRAY @[@"北京",@"上海",@"成都",@"重庆",@"深圳",@"广州",@"韩国",@"武汉",@"郑州"]

@implementation GZCCityHotCell{
    UIView *hotBgView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        UILabel *hotTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, size.width-30, 45)];
        hotTitle.font = [UIFont systemFontOfSize:15];
        hotTitle.textColor = [UIColor grayColor];
        hotTitle.text = @"热门城市";
        [self.contentView addSubview:hotTitle];
        
        hotBgView = [[UIView alloc]initWithFrame:CGRectMake(15, MaxY(hotTitle), size.width-30, size.height-MaxY(hotTitle))];
        [self.contentView addSubview:hotBgView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.hotArray == nil) {
        self.hotArray = DEFORTARRAY;
    }
}

-(void)setHotArray:(NSArray<__kindof NSString *> *)hotArray{
    _hotArray = hotArray;
    for (UIView *sub in [hotBgView subviews]) {
        [sub removeFromSuperview];
    }
    float offx = 0,offy =0;
    float width = (WIDTH(hotBgView)-20)/3;
    for (NSString *title in hotArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:BG_COLOR];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.frame = CGRectMake(offx, offy, width, 30);
        [hotBgView addSubview:btn];
        offx += width+10;
        if (offx>=WIDTH(hotBgView)) {
            offx = 0;
            offy += 40;
        }
    }
}

-(void)btnTaped:(UIButton*)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotCell:tapedCity:)]) {
        [self.delegate hotCell:self tapedCity:btn.titleLabel.text];
    }
}

@end
