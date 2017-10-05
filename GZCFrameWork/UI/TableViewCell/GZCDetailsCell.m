//
//  GZCDetailsCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCDetailsCell.h"

@implementation GZCDetailModel

@end

@implementation GZCDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 40)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        self.textView = [[SETextView alloc]initWithFrame:CGRectMake(self.contentSpace, 0, size.width-self.contentSpace*2, size.height)];
        self.textView.font = [UIFont systemFontOfSize:14];
        self.textView.textColor = mainFontColor;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.editable = NO;
        self.textView.lineSpacing = 8;
        self.textView.paragraphSpacing = 8;
        [self.contentView addSubview:self.textView];
        
        self.contentTopMargine = 5;
        self.contentBottomMargine = 5;
        self.contentLeftMargine = 10;
        self.contentRightMargine = 10;
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentSpace, 0, size.width-self.contentSpace*2, size.height)];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self getContentSize];
    self.textView.frame = CGRectMake(self.contentLeftMargine, self.contentTopMargine, size.width-self.contentLeftMargine-self.contentRightMargine, size.height-self.contentTopMargine-self.contentBottomMargine);
    self.imageV.frame = CGRectMake(self.contentLeftMargine, self.contentTopMargine, size.width-self.contentLeftMargine-self.contentRightMargine, size.height-self.contentTopMargine-self.contentBottomMargine);
}

-(void)setSize:(CGSize)size{
    [super setSize:size];
    self.textView.frame = CGRectMake(self.contentSpace, 5, size.width-self.contentSpace*2, size.height-10);
    self.imageV.frame = CGRectMake(self.contentSpace, 5, size.width-self.contentSpace*2, size.height-10);
}

-(void)setModel:(GZCDetailModel *)model{
    _model = model;
    _imageV.image = [UIImage imageWithRenderColor:BG_COLOR renderSize:CGSizeMake(1, 1)];
    if (model.type == 1) {
        self.textView.hidden = NO;
        self.imageV.hidden = YES;
        self.textView.text = model.textStr;
    }else{
        self.textView.hidden = YES;
        self.imageV.hidden = NO;
        [self.imageV setWebImage:model.imageUrl];
    }
}

-(CGSize)getContentSize{
    if (_model.type == 1) {
        CGSize textSize = [SETextView frameRectWithAttributtedString:[[NSAttributedString alloc]initWithString:_model.textStr] constraintSize:CGSizeMake(mainWidth-20, MAXFLOAT) lineSpacing:8 paragraphSpacing:8 font:[UIFont systemFontOfSize:14]].size;
        textSize.height += 10;
        return textSize;
    }
    return CGSizeMake(mainWidth, _model.imageSize.height*(mainWidth-20)/_model.imageSize.width+5);
}

+(float)getHightWithModel:(GZCDetailModel *)model{
    if (model.type == 1) {
        CGSize textSize = [SETextView frameRectWithAttributtedString:[[NSAttributedString alloc]initWithString:model.textStr] constraintSize:CGSizeMake(mainWidth-20, MAXFLOAT) lineSpacing:8 paragraphSpacing:8 font:[UIFont systemFontOfSize:14]].size;
        return textSize.height+10;
    }
    return model.imageSize.height*(mainWidth-20)/model.imageSize.width + 10;
}

@end
