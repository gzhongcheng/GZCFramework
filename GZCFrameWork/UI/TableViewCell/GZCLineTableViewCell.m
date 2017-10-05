//
//  GZCLineTableViewCell.m
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCLineTableViewCell.h"

@implementation GZCLineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 45)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.contentSpace = 10;
        self.size = size;
        self.spaceForTop = 0;
        self.spaceForBottom = 0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self resizeContent];
}

-(void)resizeContent{
    if (self.size.height==0) {
        self.contentView.frame = CGRectMake(0, self.spaceForTop, self.size.width, HEIGHT(self)-self.spaceForTop-self.spaceForBottom);
    }else{
        self.contentView.frame = CGRectMake(0, self.spaceForTop, self.size.width, self.size.height-self.spaceForTop-self.spaceForBottom);
    }
    
}

-(CALayer*)drawLineToFrame:(CGRect)frame{
    return [self drawLineToFrame:frame color:mainLineColor];
}

-(CALayer*)drawLineToFrame:(CGRect)frame color:(UIColor*)color{
    CALayer *line = [CALayer layer];
    line.backgroundColor = color.CGColor;
    line.frame = frame;
    [self.contentView.layer addSublayer:line];
    return line;
}

-(UIView*)getLine:(CGRect)frame{
    return [self getLine:frame color:mainLineColor];
}

-(UIView *)getLine:(CGRect)frame color:(UIColor *)color{
    UIView *line =[[UIView alloc]initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}

-(CGSize)getContentSize{
    return CGSizeZero;
}

+(float)getHightWithModel:(GZCBaseModel *)model{
    return 45;
}

@end
