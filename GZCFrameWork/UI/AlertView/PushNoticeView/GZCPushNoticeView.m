//
//  GZCPushNoticeView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCPushNoticeView.h"
#import "SDAutoLayout.h"
#import "LEEAlert.h"
#import "UIImageView+NoMapMode.h"
#import "NSString+Size.h"
#import "UIImage+WebSize.h"

@interface GZCPushNoticeView()

@property (nonatomic , strong ) UIImageView *imageView; //图片
@property (nonatomic , strong ) UILabel *titleLabel; //标题
@property (nonatomic , strong ) UILabel *contentLabel; //内容
@property (nonatomic , strong ) UIButton *doneButton; //设置按钮
@property (nonatomic , strong ) UIButton *colseButton; //关闭按钮

@end

@implementation GZCPushNoticeView

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
    // 图片
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"open_push_image"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    // 标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"第一时间获知重要信息";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    // 内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = @"到设置中开启推送";
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.font = [UIFont systemFontOfSize:16.0f];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    // 设置按钮
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.sd_cornerRadius = @5.0f;
    [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_doneButton setTitle:@"去设置" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_doneButton setBackgroundColor:[UIColor colorWithRed:190/255.0f green:40/255.0f blue:44/255.0f alpha:1.0f]];
    [_doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneButton];
    
    // 关闭按钮
    _colseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_colseButton setImage:[UIImage imageNamed:@"infor_colse_image"] forState:UIControlStateNormal];
    [_colseButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_colseButton];
}

#pragma mark - 设置自动布局

- (void)configAutoLayout{
    
    // 图片
    self.imageView.sd_layout
    .topSpaceToView(self , 30.0f)
    .leftSpaceToView(self , 20.0f)
    .rightSpaceToView(self , 20.0f)
    .autoHeightRatio(0.87f);
    
    // 标题
    self.titleLabel.sd_layout
    .topSpaceToView(self.imageView , 10.0f)
    .centerXEqualToView(self)
    .widthIs(200.0f)
    .heightIs(30.0f);
    
    // 内容
    self.contentLabel.sd_layout
    .topSpaceToView(self.titleLabel , 0.0f)
    .centerXEqualToView(self)
    .widthIs(200.0f)
    .heightIs(30.0f);
    
    // 设置按钮
    self.doneButton.sd_layout
    .topSpaceToView(self.contentLabel , 10.0f)
    .leftSpaceToView(self , 30.0f)
    .rightSpaceToView(self , 30.0f)
    .heightIs(40.0f);
    
    // 关闭按钮
    self.colseButton.sd_layout
    .topSpaceToView(self , 10.0f)
    .rightSpaceToView(self , 10.0f)
    .widthIs(30.0f)
    .heightIs(30.0f);
    
    [self setupAutoHeightWithBottomView:self.doneButton bottomMargin:20.0f];
}

#pragma mark -setter
//设置标题文字
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

//设置内容文字
-(void)setContent:(NSString *)content{
    _content = content;
    _contentLabel.text = content;
    _contentLabel.sd_layout
    .heightIs([content heightWithFont:_contentLabel.font
                    constrainedToSize:CGSizeMake(200, MAXFLOAT)]);
}

-(void)setDoneTitle:(NSString *)doneTitle{
    _doneTitle = doneTitle;
    [_doneButton setTitle:doneTitle forState:UIControlStateNormal];
}

//设置图片
-(void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    if (imageURL == nil || [imageURL isEqualToString:@""]) {
        _imageView.sd_layout
        .topSpaceToView(self , 20.0f)
        .autoHeightRatio(0);
        return;
    }
    CGSize imageSize;
    if ([imageURL hasPrefix:@"http"]) {
        imageSize = [UIImage getImageSizeWithURL:imageURL asynsDownLoad:NO dowmLoaderCompleted:nil];
        [_imageView setWebImage:imageURL];
    }else{
        UIImage *image = [UIImage imageNamed:imageURL];
        imageSize = image.size;
        _imageView.image = image;
    }
    float ratio = imageSize.height/imageSize.width;
    if (ratio > 1) {
        ratio = 1;
    }
    _imageView.sd_layout
    .topSpaceToView(self , 38.0f)
    .autoHeightRatio(ratio);
}

#pragma mark - Target
//确定按钮点击事件
- (void)doneButtonAction:(UIButton *)sender{
    [LEEAlert closeWithCompletionBlock:^{
        if (self.doneBlock) {
            self.doneBlock();
        }
    }];
}

//关闭按钮点击事件
- (void)closeButtonAction:(UIButton *)sender{
    [LEEAlert closeWithCompletionBlock:^{
        if (self.closeBlock){
            self.closeBlock();
        }
    }];
}

@end
