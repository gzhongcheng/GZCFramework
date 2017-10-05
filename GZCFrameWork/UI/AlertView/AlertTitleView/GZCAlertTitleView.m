//
//  GZCAlertTitleView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCAlertTitleView.h"
#import "SDAutoLayout.h"
#import "NSString+Size.h"
#import "UtilsMacros.h"

@interface GZCAlertTitleView()

@property (nonatomic , strong ) UILabel *titleLabel; //标题
@property (nonatomic , strong ) UIView  *titleBackground;//标题背景色
@property (nonatomic , strong ) UILabel *contentLabel; //内容

@end


@implementation GZCAlertTitleView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化数据
        [self initData];
        //初始化子视图
        [self initSubview];
        //设置自动布局
        [self configAutoLayout];
    }
    return self;
}

#pragma mark - 初始化数据

- (void)initData{
    
}

#pragma mark - 初始化子视图

- (void)initSubview{
    
    _titleBackground = [[UIView alloc]init];
    [self addSubview:_titleBackground];
    
    // 标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleBackground addSubview:_titleLabel];
    
    // 内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"到设置中开启推送";
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.font = [UIFont systemFontOfSize:16.0f];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
}

#pragma mark - 设置自动布局

- (void)configAutoLayout{
    float textMaxWidth = self.width - 40.f;
    
    //标题背景
    self.titleBackground.sd_layout
    .topSpaceToView(self, 0.f)
    .leftSpaceToView(self, 0.f)
    .rightSpaceToView(self, 0.f);
    
    // 标题
    self.titleLabel.sd_layout
    .centerXEqualToView(self.titleBackground)
    .centerYEqualToView(self.titleBackground)
    .topSpaceToView(self.titleBackground, 10.0f)
    .widthIs(textMaxWidth);
    
    [self.titleBackground setupAutoHeightWithBottomView:self.titleLabel bottomMargin:10.0f];
    
    // 内容
    self.contentLabel.sd_layout
    .topSpaceToView(self.titleBackground , 10.0f)
    .centerXEqualToView(self)
    .widthIs(textMaxWidth)
    .heightIs(30.0f);
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:10.0f];
}

#pragma mark -setter
//设置标题文字
-(void)setTitle:(GZCAlertItem *)title{
    _title = title;
    if (title.exist) {
        _titleLabel.text = title.text;
        _titleLabel.textColor = title.textColor;
        _titleLabel.font = title.font;
        _titleBackground.backgroundColor = title.backgroundColor;
        float height =[title.text heightWithFont:_contentLabel.font
                                 constrainedToSize:CGSizeMake(_titleLabel.width, MAXFLOAT)];
        _titleLabel.sd_layout
        .heightIs(height > 20.f ? height : 20.f);
        [self.titleBackground setupAutoHeightWithBottomView:self.titleLabel bottomMargin:10.0f];
    }else{
        _titleLabel.sd_layout.heightIs(0);
        [self.titleBackground setupAutoHeightWithBottomView:self.titleLabel bottomMargin:0.f];
    }
}

-(void)setMessage:(GZCAlertItem *)message{
    _message = message;
    if (message.exist) {
        _contentLabel.text = message.text;
        _contentLabel.textColor = message.textColor;
        _contentLabel.font = message.font;
        float height =[message.text heightWithFont:_contentLabel.font
                                 constrainedToSize:CGSizeMake(_contentLabel.width, MAXFLOAT)];
        _contentLabel.sd_layout
        .heightIs(height > 40.f ? height : 40.f);
        self.backgroundColor = message.backgroundColor;
        
        [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:10.0f];
    }else{
        _contentLabel.sd_layout
        .heightIs(0);
        
        [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:0.f];
    }
}

@end
