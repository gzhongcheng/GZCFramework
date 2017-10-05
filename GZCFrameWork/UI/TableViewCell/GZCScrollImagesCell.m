//
//  GZCScrollImagesCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCScrollImagesCell.h"
#import "GZCFramework.h"

@implementation GZCScrImageModel

@end

@implementation GZCTitleImage

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    float titleY = 0;
    float subTitleY = 0;
    switch (self.style) {
        case GZCScrollImageStyleTop:
            titleY = 0;
            break;
        case GZCScrollImageStyleCenter:
            titleY = MidY(self)-10;
            break;
        case GZCScrollImageStyleCenterWithSubTitle:
            titleY = MidY(self)-20;
            subTitleY = MidY(self);
            break;
        case GZCScrollImageStyleBottom:
            titleY = HEIGHT(self)-20;
            break;
    }
    _titleLabel.frame = CGRectMake(0, titleY, WIDTH(self), 20);
    _subTitleLabel.frame = CGRectMake(0, subTitleY, WIDTH(self), 20);
    _titleLabel.text = self.model.title;
    _subTitleLabel.text = self.model.subTitle;
    [self.imageView setWebImage:webImageBaseUrl image:self.model.imageUrl placeholderImage:webPlaceHolderImage];
}

@end

@implementation GZCScrollImagesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        _imageSize = CGSizeZero;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [self.contentView addSubview:_scrollView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, self.contentSpace, self.size.width, HEIGHT(self.contentView)-2*self.contentSpace);
    
    for (GZCTitleImage *img in [_scrollView subviews]) {
        [img removeFromSuperview];
    }
    float offX = 10;
    int index = 0;
    if (_imageSize.width==0&&_imageSize.height==0) {
        _imageSize = CGSizeMake((WIDTH(_scrollView)-10)/2, HEIGHT(_scrollView));
    }
    for (GZCScrImageModel *model in _btnModels) {
        GZCTitleImage *img = [[GZCTitleImage alloc]initWithFrame:CGRectMake(offX, 0,self.imageSize.width, self.imageSize.height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTaped:)];
        [img addGestureRecognizer:tap];
        img.titleLabel.textColor = self.titleColor;
        img.titleLabel.backgroundColor = self.titleBgColor;
        [img setModel:model];
        [self.scrollView addSubview:img];
        index++;
        offX += _imageSize.width + 10;
    }
    _scrollView.contentSize = CGSizeMake(offX, HEIGHT(_scrollView));
}

-(void)setBlock:(GZCScrollImageTaped)block{
    self.tapBlock = block;
}

-(void)imgTaped:(GZCTitleImage*)btn{
    if (_tapBlock) {
        _tapBlock(btn.model);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(GZCScrollImageTaped:)]) {
        [self.delegate GZCScrollImageTaped:btn.model];
    }
}

@end
