//
//  GZCQiandaoNoticeView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCQiandaoNoticeView.h"
#import "SDAutoLayout.h"
#import "LEEAlert.h"
#import "UIImageView+NoMapMode.h"

@interface GZCQiandaoNoticeView()

@property (nonatomic , strong ) UIImageView *prizeImageView;    //奖品图片
@property (nonatomic , strong ) UIImageView *bgImageView;       //背景图片
@property (nonatomic , strong ) UILabel *scoreLabel;            // 分数
@property (nonatomic , strong ) UILabel *daysLabel;             // 天数
@property (nonatomic , strong ) UILabel *descLabel;             // 描述
@property (nonatomic , strong ) UIButton *doneButton;           // 打开按钮
@property (nonatomic , strong ) UIButton *colseButton;          // 关闭按钮

@end

@implementation GZCQiandaoNoticeView

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
    
    // 背景图片
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qiandaobg"]];
    [self addSubview:_bgImageView];
    
    // 奖励图片
    _prizeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jindou"]];
    _prizeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bgImageView addSubview:_prizeImageView];
    
    // 分数
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.text = @"+5";
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = [UIFont boldSystemFontOfSize:28.0f];
    [self.bgImageView addSubview:_scoreLabel];
    
    // 天数
    _daysLabel = [[UILabel alloc] init];
    _daysLabel.text = @"已成功签到1天";
    _daysLabel.textColor = [UIColor whiteColor];
    _daysLabel.font = [UIFont systemFontOfSize:14.0f];
    _daysLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgImageView addSubview:_daysLabel];
    
    // 描述
    _descLabel = [[UILabel alloc] init];
    _descLabel.text = @"积分可用于竞猜并参与抽奖";
    _descLabel.textColor = [UIColor blackColor];
    _descLabel.font = [UIFont systemFontOfSize:16.0f];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgImageView addSubview:_descLabel];
    
    // 设置按钮
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.sd_cornerRadius = @5.0f;
    [_doneButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [_doneButton setTitle:@"去竞猜" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_doneButton setBackgroundColor:[UIColor colorWithRed:34/255.0f green:129/255.0f blue:239/255.0f alpha:1.0f]];
    [_doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneButton];
    
    // 关闭按钮
    _colseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _colseButton.highlighted = NO;
    _colseButton.sd_cornerRadiusFromWidthRatio = @.5f;
    _colseButton.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.5f];
    [_colseButton setImage:[UIImage imageNamed:@"infor_colse_image"] forState:UIControlStateNormal];
    [_colseButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_colseButton];
}

#pragma mark - 设置自动布局

- (void)configAutoLayout{
    
    // 背景图片
    self.bgImageView.sd_layout
    .topSpaceToView(self , 40.0f)
    .leftSpaceToView(self , 0.0f)
    .rightSpaceToView(self , 0.0f)
    .autoHeightRatio(1.07f);
    
    // 分数
    self.scoreLabel.sd_layout
    .topSpaceToView(self.bgImageView, 60.0f)
    .rightSpaceToView(self.bgImageView, 80.0f)
    .widthIs(50.0f)
    .heightIs(30.0f);
    
    // 奖励图片
    self.prizeImageView.sd_layout
    .topSpaceToView(self.scoreLabel, -15.0f)
    .rightSpaceToView(self.scoreLabel, -20.0f)
    .widthIs(70.0f)
    .heightIs(70.0f);
    
    // 天数
    self.daysLabel.sd_layout
    .topSpaceToView(self.bgImageView , 145.0f)
    .centerXEqualToView(self)
    .widthIs(150.0f)
    .heightIs(30.0f);
    
    // 描述
    self.descLabel.sd_layout
    .bottomSpaceToView(self.bgImageView, 25.0f)
    .leftSpaceToView(self.bgImageView, 20.0f)
    .rightSpaceToView(self.bgImageView, 20.0f)
    .heightIs(30.0f);
    
    // 打开按钮
    self.doneButton.sd_layout
    .topSpaceToView(self.bgImageView , 10.0f)
    .leftSpaceToView(self , 15.0f)
    .rightSpaceToView(self , 15.0f)
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

-(void)setSroce:(NSString *)sroce{
    _sroce = sroce;
    _scoreLabel.text = sroce;
}

-(void)setDay:(NSString *)day{
    _day = day;
    _descLabel.text = day;
}

-(void)setDesc:(NSString *)desc{
    _desc = desc;
    _descLabel.text = desc;
}

-(void)setDoneTitle:(NSString *)doneTitle{
    _doneTitle = doneTitle;
    [_doneButton setTitle:doneTitle forState:UIControlStateNormal];
}

-(void)setPrizeURL:(NSString *)prizeURL{
    _prizeURL = prizeURL;
    if ([prizeURL hasPrefix:@"http"]) {
        [_prizeImageView setWebImage:prizeURL];
    }else{
        _prizeImageView.image = [UIImage imageNamed:prizeURL];
    }
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
