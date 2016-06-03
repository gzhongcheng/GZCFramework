//
//  GZCAdBtnTableViewCell.m
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/29.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCAdBtnTableViewCell.h"
#import "UIImageView+NoMapMode.h"

@implementation GZCAdBtnModel

@end

@interface GZCAdButton : UIControl


@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel     *titleLabel;
@property(nonatomic,strong) UILabel     *subTitleLabel;
@property(nonatomic,strong) GZCAdBtnModel *model;

-(void)setTitleColor:(UIColor *)titleColor;
-(void)setSubTitleColor:(UIColor *)titleColor;

@end

@implementation GZCAdButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,HEIGHT(self)-25, HEIGHT(self)-25)];
        _imageView.center = CGPointMake(WIDTH(self)/2, (HEIGHT(self)-25)/2);
        _imageView.contentMode = UIViewContentModeCenter;
//        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)+3, CGRectGetWidth(self.frame), 20)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(self.frame), 20)];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_subTitleLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.text = _model.title;
    if (_model.imageName!=nil&&![_model.imageName isEqualToString:@""]) {
        self.imageView.image = [[UIImage imageNamed:_model.imageName] reSizeToSize:_imageView.frame.size];
    }else{
        if (_model.imageSize.width&&_model.imageSize.height) {
//            self.imageView.frame = CGRectMake(MinX(_imageView), MinY(_imageView), _model.imageSize.width, _model.imageSize.height);
        }else{
//            _imageView.frame = CGRectMake(0, 0,HEIGHT(self)-20, HEIGHT(self)-20);
            _model.imageSize = _imageView.frame.size;
        }
        _imageView.center = CGPointMake(WIDTH(self)/2, (HEIGHT(self)-25)/2);
//        [self.imageView setWebImage:webHeadBaseUrl image:_model.imageUrl];
        __weak UIImageView *wimgv = self.imageView;
        __weak GZCAdBtnModel *wModel = self.model;
        [self.imageView setWebImage:_model.imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            wimgv.image = [image reSizeToSize:CGSizeMake( wModel.imageSize.width,  wModel.imageSize.height)];
        }];
    }
    if (_model.subTitle!=nil&&![_model.subTitle isEqualToString:@""]) {
        self.subTitleLabel.hidden = NO;
        self.subTitleLabel.text = _model.subTitle;
    }else{
        self.subTitleLabel.hidden = YES;
    }
//    imageBgView.image = _model.bgImage;
    _imageView.backgroundColor = [UIColor colorWithPatternImage:[_model.bgImage reSizeToSize:_imageView.frame.size]];
}

-(void)setTitleColor:(UIColor *)titleColor{
    self.titleLabel.textColor = titleColor;
}

-(void)setSubTitleColor:(UIColor *)titleColor{
    self.subTitleLabel.textColor = titleColor;
}

@end

@implementation GZCAdBtnTableViewCell{
    NSMutableArray <__kindof GZCAdButton*>*buttons;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        _line = [self drawLineToFrame:CGRectMake(0, size.height-1, size.width, 1)];
        self.numberOfButtonForLine = 4;
        self.rowSpace = 10;
        buttons = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _line.frame =CGRectMake(0, HEIGHT(self.contentView)-1, WIDTH(self.contentView), 1);
    for (GZCAdButton *btn in buttons) {
        [btn removeFromSuperview];
    }
    [buttons removeAllObjects];
    float offX=self.contentSpace,offY=0;
    float btnWidth = (WIDTH(self.contentView)-self.contentSpace*2)/self.numberOfButtonForLine;
    float row = ceilf([_btnModels count]/(float)self.numberOfButtonForLine);
    float btnHeight = (HEIGHT(self.contentView)-_rowSpace*row)/row;
    for (GZCAdBtnModel *model in _btnModels) {
        GZCAdButton *btn = [[GZCAdButton alloc]initWithFrame:CGRectMake(offX, offY,btnWidth, btnHeight)];
        [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:mainFontColor];
        [btn setModel:model];
        [self.contentView addSubview:btn];
        [buttons addObject:btn];
        
        offX += btnWidth;
        if (offX >= (WIDTH(self.contentView)-self.contentSpace*2)) {
            offY += btnHeight+_rowSpace;
            offX = self.contentSpace;
        }
    }
}

-(void)setBlock:(AdBtnTaped)block{
    self.tapBlock = block;
}

-(void)btnTaped:(GZCAdButton*)btn{
    if (_tapBlock) {
        _tapBlock(btn.model);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(adBtnTaped:)]) {
        [self.delegate adBtnTaped:btn.model];
    }
}

@end


