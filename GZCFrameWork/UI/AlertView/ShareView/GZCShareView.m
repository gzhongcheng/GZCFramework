//
//  GZCShareView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/14.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCShareView.h"
#import "SDAutoLayout.h"
#import "UIImageView+NoMapMode.h"
#import "UIButton+WebCache.h"

@interface GZCShareView () <UIScrollViewDelegate>

@property (nonatomic , strong ) UIScrollView *scrollView;
@property (nonatomic , strong ) UIPageControl *pageControl;
@property (nonatomic , strong ) NSArray *infoArray;
@property (nonatomic , strong ) NSMutableArray *buttonArray;
@property (nonatomic , strong ) NSMutableArray *pageViewArray;

@end

@implementation GZCShareView
{
    NSInteger lineMaxNumber; //最大行数
    NSInteger singleMaxCount; //单行最大个数
}

- (void)dealloc{
    _scrollView = nil;
    _pageControl = nil;
    _infoArray = nil;
    _buttonArray = nil;
    _pageViewArray = nil;
}

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount{
    self = [super initWithFrame:frame];
    if (self) {
        _infoArray = infoArray;
        _buttonArray = [NSMutableArray array];
        _pageViewArray = [NSMutableArray array];
        lineMaxNumber = maxLineNumber;
        singleMaxCount = maxSingleCount;
        
        //初始化数据
        [self initData];
        //初始化子视图
        [self initSubview];
        //设置自动布局
        [self configAutoLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    return [self initWithFrame:frame InfoArray:nil MaxLineNumber:0 MaxSingleCount:0];
}

#pragma mark - 初始化数据

- (void)initData{
    //非空判断 设置默认数据
    if (!_infoArray) {
        _infoArray = @[];
    }
    
    lineMaxNumber = lineMaxNumber > 0 ? lineMaxNumber : 2;
    singleMaxCount = singleMaxCount > 0 ? singleMaxCount : 3;
}

#pragma mark - 初始化子视图

- (void)initSubview{
    //初始化滑动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    //初始化pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
    
    //循环初始化分享按钮
    NSInteger index = 0;
    UIView *pageView = nil;
    for (NSDictionary *info in _infoArray) {
        //判断是否需要分页
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            //初始化页视图
            pageView = [[UIView alloc] init];
            [_scrollView addSubview:pageView];
            [_pageViewArray addObject:pageView];
        }
        //初始化按钮
        GZCShareButton *button = [GZCShareButton buttonWithType:UIButtonTypeCustom];
        NSString *imageUrl = info[@"image"];
        NSString *heightUrl = info[@"highlightedImage"];
        if (heightUrl == nil || [heightUrl isEqualToString:@""]) {
            heightUrl = nil;
        }
        [button configTitle:info[@"title"] Image:imageUrl highlightedImage:info[@"highlightedImage"]];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:button];
        [_buttonArray addObject:button];
        index++;
    }
    //设置总页数
    _pageControl.numberOfPages = _pageViewArray.count > 1 ? _pageViewArray.count : 0;
}

#pragma mark - 设置自动布局

- (void)configAutoLayout{
    //使用SDAutoLayout循环布局分享按钮
    NSInteger lineNumber = ceilf((double)_infoArray.count / singleMaxCount); //所需行数 小数向上取整
    NSInteger singleCount = ceilf((double)_infoArray.count / lineNumber); //单行个数 小数向上取整
    singleCount = singleCount >= _infoArray.count ? singleCount : singleMaxCount ; //处理单行个数
    CGFloat buttonSpace = 3.f;
    CGFloat buttonWidth = (self.width - buttonSpace) / singleCount - buttonSpace;
    CGFloat buttonHeight = buttonWidth + 20 + buttonSpace;
    NSInteger index = 0;
    NSInteger currentPageCount = 0;
    UIView *pageView = nil;
    for (GZCShareButton *button in _buttonArray) {
        button.space = buttonSpace;
        //判断是否分页
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            pageView = _pageViewArray[currentPageCount];
            //布局页视图
            if (currentPageCount == 0) {
                pageView.sd_layout
                .leftSpaceToView(_scrollView , 0)
                .topSpaceToView(_scrollView , 0)
                .rightSpaceToView(_scrollView , 0)
                .heightIs((lineNumber > lineMaxNumber ? lineMaxNumber : lineNumber ) * buttonHeight);
            } else {
                pageView.sd_layout
                .leftSpaceToView(_pageViewArray[currentPageCount - 1] , 0)
                .topSpaceToView(_scrollView , 0)
                .widthRatioToView(_pageViewArray[currentPageCount - 1] , 1)
                .heightRatioToView(_pageViewArray[currentPageCount - 1] , 1);
            }
            currentPageCount ++;
        }
        //布局按钮
        if (index == 0) {
            button.sd_layout
            .leftSpaceToView(pageView , buttonSpace)
            .topSpaceToView(pageView , 0)
            .widthIs(buttonWidth)
            .heightIs(buttonHeight);
        } else {
            if (index % singleCount == 0) {
                //判断是否分页 如果分页 重新调整按钮布局参照
                if (index % (lineMaxNumber * singleMaxCount) == 0) {
                    button.sd_layout
                    .leftSpaceToView(pageView , buttonSpace)
                    .topSpaceToView(pageView , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                } else {
                    button.sd_layout
                    .leftSpaceToView(pageView , buttonSpace)
                    .topSpaceToView(_buttonArray[index - singleCount] , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                }
            } else {
                button.sd_layout
                .leftSpaceToView(_buttonArray[index - 1] , buttonSpace)
                .topEqualToView(_buttonArray[index - 1])
                .widthIs(buttonWidth)
                .heightIs(buttonHeight);
            }
        }
        index ++;
    }
    
    //滑动视图
    _scrollView.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self, 0.0f)
    .rightSpaceToView(self , 0.0f)
    .heightRatioToView(_pageViewArray.lastObject , 1);
    
    [_scrollView setupAutoContentSizeWithRightView:_pageViewArray.lastObject rightMargin:0.0f];
    [_scrollView setupAutoContentSizeWithBottomView:_pageViewArray.lastObject bottomMargin:0.0f];
    
    //pageControl
    if (currentPageCount > 1) {
        _pageControl.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(_scrollView , 5.0f)
        .heightIs(10.0f);
    }else{
        _pageControl.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(_scrollView , 0.0f)
        .heightIs(0.0f);
    }
    
    [self setupAutoHeightWithBottomView:_pageControl bottomMargin:0.0f];
}

#pragma mark - 分享按钮点击事件

- (void)shareButtonAction:(UIButton *)sender{
    NSInteger index = [self.buttonArray indexOfObject:sender];
    NSString *tag = self.infoArray[index][@"tag"];
    if (self.ShareButtonTapedBlock) {
        self.ShareButtonTapedBlock(index,tag);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //通过最终的偏移量offset值 来确定pageControl当前应该显示第几页
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

@end

@implementation GZCShareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _space = 10.0f;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)setSpace:(CGFloat)space{
    _space = space;
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    float length = [self.titleLabel.text length] > 4 ? [self.titleLabel.text length] : 4;
    float fontSize = self.frame.size.width/length -1;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize > 14 ? 14 : fontSize];
    
    //图片
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    //修正位置
    CGRect imageFrame = [self imageView].frame;
    imageFrame.origin.y = 0;//(self.frame.size.height - imageFrame.size.height - self.titleLabel.frame.size.height - _space ) / 2;
    imageFrame.size.width = self.frame.size.width;
    imageFrame.size.height = self.frame.size.width;
    self.imageView.frame = imageFrame;
    
    //标题
    CGRect titleFrame = [self titleLabel].frame;
    titleFrame.origin.x = 0;
    titleFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + _space;
    titleFrame.size.height = 20 ;
    titleFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = titleFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (center.y == 0) {
        CGPoint titleCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.titleLabel.center = titleCenter;
    }
}

- (void)setWebImage:(NSString *)imageUrl{
    [self.imageView setWebImage:imageUrl];
}

- (void)configTitle:(NSString *)title Image:(NSString *)image highlightedImage:(NSString *)highlightedimage{
    [self setTitle:title forState:UIControlStateNormal];
    if ([image hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [self layoutSubviews];
        }];
    }else{
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedimage ==nil){
        return;
    }
    if ([highlightedimage hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:highlightedimage] forState:UIControlStateHighlighted placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [self layoutSubviews];
        }];
    }else{
        [self setImage:[UIImage imageNamed:highlightedimage] forState:UIControlStateHighlighted];
    }
}

@end
