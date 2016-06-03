//
//  GZCIconTextCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/15.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCIconTextCell.h"

@implementation GZCIconTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 45)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.contentView.backgroundColor = BG_COLOR;
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0,20, 20)];
        [self.contentView addSubview:_iconImageView];
        
        self.iconSize = CGSizeMake(20, 20);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        self.titleColor = mainFontColor;
        
        self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_subTitleLabel];
        
        self.subTitleColor = mainFontColor;
        
        self.showsArrow = YES;
        
        _marginHorizontal = 0;
        self.line = [self drawLineToFrame:CGRectMake(_marginHorizontal, size.height-1, size.width-_marginHorizontal*2, 1)];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_showsArrow) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    self.iconImageView.frame = CGRectMake(_marginHorizontal, 0, _iconSize.width, _iconSize.height);
    self.iconImageView.center = CGPointMake(_iconImageView.center.x, (self.size.height-1)/2);
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.frame = CGRectMake(self.size.width-WIDTH(self.subTitleLabel)-35, 0, WIDTH(self.subTitleLabel), HEIGHT(self.contentView));
//    self.subTitleLabel.backgroundColor = BG_COLOR;
    self.subTitleLabel.textColor = self.subTitleColor;
    
    self.titleLabel.frame = CGRectMake(MaxX(self.iconImageView)+self.contentSpace, 0, MinX(self.subTitleLabel)-MaxX(self.iconImageView)-10, HEIGHT(self.contentView));
//    self.titleLabel.backgroundColor = BG_COLOR;
    self.titleLabel.textColor = self.titleColor;
    
    self.line.frame = CGRectMake(_marginHorizontal, self.size.height-1, self.size.width-_marginHorizontal*2, 1);
}

+(float)getHightWithModel:(GZCBaseModel *)model{
    return 45;
}

@end
