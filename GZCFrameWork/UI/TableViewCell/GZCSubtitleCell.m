//
//  GZCSubtitleCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/11.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCSubtitleCell.h"

@implementation GZCSubtitleCell{
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 100)]) {
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier size:size];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.myImageView];
        
        self.textLabel.font = [UIFont systemFontOfSize:17];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.textColor = [UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, self.spaceForTop, self.size.width, self.size.height-self.spaceForTop-self.spaceForBottom);
    
    self.myImageView.frame = CGRectMake(10, self.contentSpace, HEIGHT(self.contentView)-self.contentSpace*2, HEIGHT(self.contentView)-self.contentSpace*2);
    self.myImageView.layer.cornerRadius = WIDTH(self.myImageView)/2;
    
    self.imageView.backgroundColor = [UIColor grayColor];
    
    self.textLabel.frame = CGRectMake(MaxX(self.myImageView)+10, self.contentSpace, self.size.width - MaxX(self.imageView), 20);
    
    self.detailTextLabel.frame = CGRectMake(MinX(self.textLabel), HEIGHT(self.contentView) - self.contentSpace - 20, self.size.width - MaxX(self.imageView), 20);
    
}

-(void)setWebImage:(NSString *)imageUrl{
    [self.myImageView setWebImage:nil image:imageUrl];
}


@end
