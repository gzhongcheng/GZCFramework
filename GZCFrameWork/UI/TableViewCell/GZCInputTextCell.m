//
//  GZCInputTextCell.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/29.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCInputTextCell.h"

@implementation GZCInputTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier size:CGSizeMake(mainWidth, 45)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier size:size]) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentSpace, 0, 0, size.height)];
        _placeLabel.font = [UIFont systemFontOfSize:13];
        _placeLabel.textColor = mainFontColor;
        [self.contentView addSubview:_placeLabel];
        
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.contentSpace, 0, size.width-self.contentSpace*2, size.height)];
        _inputTextField.font = [UIFont systemFontOfSize:13];
        _inputTextField.tintColor = mainColor;
        [self.contentView addSubview:_inputTextField];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect pf = _placeLabel.frame;
    pf.size.width = self.placeWidth;
    _placeLabel.frame = pf;
    _inputTextField.frame = CGRectMake(MaxX(_placeLabel), MinY(_inputTextField), self.size.width - MaxX(_placeLabel)-self.contentSpace-30, HEIGHT(_inputTextField));
}

+(float)getHightWithModel:(GZCBaseModel *)model{
    return 45;
}

@end
