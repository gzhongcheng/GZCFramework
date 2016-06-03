//
//  GZCSegmentControl.m
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/2/25.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCSegmentControl.h"
#import "UIColor+Transformation.h"

#define DefaultCurrentBtnColor [UIColor grayColor]


#pragma mark - GZCSegmentButton

@interface GZCSegmentButton ()

@end

@implementation GZCSegmentButton

@end

#pragma mark - GZCSegmentControl

@interface GZCSegmentControl ()
{
    NSUInteger _btnCount; // 按钮总数
    
    CGFloat _btnWidth; // 按钮宽度
    
    GZCSegmentButton *_currentBtn;   // 指示视图当前所在的按钮
    
    UIView *_indicatorView; // 指示视图(滑动视图)
    
    BOOL _isSelectedBegan; // 是否设置了selectedBegan
    BOOL _isScrollerToLeft;
    
    float beginPercent;
    float lastPercent;
    float lineOffY;
    UIButton *nextButton;
}

@property (nonatomic, strong) NSMutableArray *buttons; // 存放button

@end



@implementation GZCSegmentControl

@synthesize indicatorViewColor = _indicatorViewColor;


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius  = frame.size.height / 10;
        self.layer.masksToBounds = YES;
        self.style = GZCSegmentControlStyleRound;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(GZCSegmentControlStyle)style{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius  = frame.size.height / 10;
        self.layer.masksToBounds = YES;
        self.style = style;
    }
    return self;
}

#pragma mark setter/getter方法

/**
 *  设置按钮标题数组
 */
- (void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    
    _btnCount = [_titles count];
    
    [self createUI];
}

/**
 *  设置圆角半径
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    if (_style == GZCSegmentControlStyleRound) {
        _indicatorView.layer.cornerRadius = _cornerRadius;
        self.layer.cornerRadius = _cornerRadius;
    }
}

/**
 *  设置保存按钮的数组
 */
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

/**
 *  设置指示视图的背景色
 */
- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor
{
    if (indicatorViewColor == nil) {
        return;
    }
    _indicatorViewColor = indicatorViewColor;
    _indicatorView.backgroundColor = _indicatorViewColor;
    for (int i = 0; i < _btnCount; i++) {
        GZCSegmentButton *btn = self.buttons[i];
        [btn setTitleColor:indicatorViewColor forState:UIControlStateHighlighted];
    }
}

/**
 *  获取指示视图的背景色
 */
- (UIColor *)indicatorViewColor
{
    if (_indicatorViewColor == nil) {
        _indicatorViewColor = [UIColor whiteColor];
    }
    return _indicatorViewColor;
}

/**
 *  设置按钮上文字颜色
 */
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    for (int i = 0; i < _btnCount; i++) {
        GZCSegmentButton *btn = self.buttons[i];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
    }
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = selectedTitleColor;
    [_currentBtn setTitleColor:self.selectedTitleColor forState:UIControlStateNormal];
}

-(void)setTitleFont:(UIFont*)font{
    _titleFont = font;
    
    for (int i = 0; i < _btnCount; i++) {
        GZCSegmentButton *btn = self.buttons[i];
        btn.titleLabel.font = font;
    }
}

-(void)setSelectedTitleColors:(NSArray *)selectedTitleColors{
    _selectedTitleColors = [selectedTitleColors copy];
    [_currentBtn setTitleColor:[self getCurrentButtonColor] forState:UIControlStateNormal];
    for (int i = 0; i < _btnCount; i++) {
        GZCSegmentButton *btn = self.buttons[i];
        [btn setTitleColor:[self getCurrentButtonColor] forState:UIControlStateHighlighted];
    }
}

-(UIColor *)getCurrentButtonColor{
    return [self getButtonColorAtIndex:(int)_currentBtn.tag];
}

-(UIColor *)getButtonColorAtIndex:(int)index{
    UIColor *selColor = self.selectedTitleColor==nil?_selectedTitleColors[index]:self.selectedTitleColor;
    if (selColor == nil) {
        selColor = DefaultCurrentBtnColor;
    }
    return selColor;
}

#pragma mark 创建视图
- (void)createUI
{
    _btnWidth = self.frame.size.width / _btnCount;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat lineHeight = btnHeight;
    lineOffY = 0;
    switch (_style) {
        case GZCSegmentControlStyleRound:
            lineHeight = btnHeight;
            lineOffY = 0;
            break;
        case GZCSegmentControlStyleLine:
            _indicatorView.layer.cornerRadius = 0;
            lineHeight = 3;
            lineOffY = CGRectGetHeight(self.frame)-3;
            break;
        case GZCSegmentControlStyleNone:
            lineHeight = 0;
            lineOffY = 0;
            break;
    }
    
    // 指示视图
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, lineOffY, _btnWidth, lineHeight)];
    if (_style == GZCSegmentControlStyleRound) {
        _indicatorView.layer.cornerRadius = self.layer.cornerRadius;
    }
    _indicatorView.backgroundColor = self.indicatorViewColor;
    [self addSubview:_indicatorView];
    
    // 创建各个按钮
    for (int i = 0; i < _btnCount; i++)
    {
        GZCSegmentButton *btn = [GZCSegmentButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(_btnWidth * i, 0, _btnWidth, btnHeight);
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.titleLabel.text = self.titles[i];
        [btn.titleLabel sizeToFit];
        btn.titleLabel.center = CGPointMake(_btnWidth/2, btnHeight/2);
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        [self.buttons addObject:btn]; // 加入数组
    }
    
    [self setSelectedIndex:0 animation:NO];
}

#pragma mark 按钮点击事件处理
- (void)btnClicked:(UIButton *)btn
{
    [self setSelectedIndex:btn.tag animation:YES];
}

#pragma mark 设置选中按钮
-(void)setSelectedIndex:(NSInteger)index{
    [self setSelectedIndex:index animation:NO];
}

- (void)setSelectedIndex:(NSInteger)index animation:(BOOL)animation
{
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]) {
        [self.delegate segmentControl:self didSelectedIndex:index];
    }
    [_currentBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
    _currentBtn = self.buttons[index];
    float width =_currentBtn.frame.size.width;
    float offX = _btnWidth * index;
    if (_style == GZCSegmentControlStyleLine&&_currentBtn.titleLabel.frame.size.width>0) {
        width = _currentBtn.titleLabel.frame.size.width;
        offX = _btnWidth * index+_currentBtn.titleLabel.frame.origin.x;
    }
    if (animation) {
        [UIView animateWithDuration:0.25f animations:^{
            _indicatorView.frame = CGRectMake(offX, lineOffY, width, _indicatorView.frame.size.height);
            if(_selectedColors!=nil&&[_selectedColors count]>=index){
                _indicatorView.backgroundColor = _selectedColors[index];
            }
            [_currentBtn setTitleColor:[self getCurrentButtonColor] forState:UIControlStateNormal];
        }];
    }else{
        _indicatorView.frame = CGRectMake(offX, lineOffY, width, _indicatorView.frame.size.height);
        if(_selectedColors!=nil&&[_selectedColors count]>=index){
            _indicatorView.backgroundColor = _selectedColors[index];
        }
        [_currentBtn setTitleColor:[self getCurrentButtonColor] forState:UIControlStateNormal];
    }
}

-(void)selectedIndex:(NSInteger)index{
    _currentBtn = self.buttons[index];
    [_currentBtn setTitleColor:[self getCurrentButtonColor] forState:UIControlStateNormal];
    
    for (UIButton *btn in _buttons) {
        if (btn!=_currentBtn) {
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
    }
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]) {
        [self.delegate segmentControl:self didSelectedIndex:index];
    }
}

- (void)selectedBegan:(CGFloat)percent
{
    beginPercent = percent;
    lastPercent = percent;
    _isSelectedBegan = YES;
    _isScrollerToLeft = NO;
}

- (void)selectedEnd:(CGFloat)percent
{
    _isSelectedBegan = NO;
    [self selectedIndex:(int)percent];
    if (_style == GZCSegmentControlStyleLine) {
        [UIView animateWithDuration:.2f animations:^{
            _indicatorView.frame = CGRectMake(_btnWidth * percent+_currentBtn.titleLabel.frame.origin.x, lineOffY,  _currentBtn.titleLabel.frame.size.width, _indicatorView.frame.size.height);
        }];
    }
}

- (void)setIndicatorViewPercent:(CGFloat)percent {
    CGRect frame = _indicatorView.frame;
    if (_style == GZCSegmentControlStyleRound) {
        frame.origin.x = _btnWidth * percent;
        _indicatorView.frame = frame;
    }
    if (ceilf(percent) > 0&&[_selectedColors count]>ceilf(percent)) {
        if(_selectedColors!=nil){
            UIColor *fromColor = _selectedColors[(int)floorf(percent)];
            UIColor *toColor = _selectedColors[(int)ceilf(percent)];
            float newPercent = percent - (int)percent;
            _indicatorView.backgroundColor = [UIColor colorWithTransformationFormColor:fromColor toColor:toColor percent:newPercent];
            if (percent-lastPercent>0) {
                if (_isSelectedBegan||percent>_currentBtn.tag) {
                    nextButton = _buttons[(int)ceilf(percent)];
                    _isScrollerToLeft = NO;
                    if (newPercent == 0) {
                        newPercent = 1;
                    }
                }
            }else{
                if (_isSelectedBegan||percent<_currentBtn.tag) {
                    nextButton = _buttons[(int)floorf(percent)];
                    _isScrollerToLeft = YES;
                }
            }
            if (_isScrollerToLeft&&(int)beginPercent==(int)percent+1) {
                [_currentBtn setTitleColor:[UIColor colorWithTransformationFormColor:self.titleColor toColor:[self getCurrentButtonColor] percent:newPercent] forState:UIControlStateNormal];
                [nextButton setTitleColor:[UIColor colorWithTransformationFormColor:[self getButtonColorAtIndex:(int)nextButton.tag] toColor:self.titleColor percent:newPercent] forState:UIControlStateNormal];
                
                if (_style == GZCSegmentControlStyleLine&&newPercent>0&&newPercent<1) {
                    float fromeWidth = CGRectGetWidth(_currentBtn.titleLabel.frame);
                    float toWidth = CGRectGetWidth(nextButton.titleLabel.frame);
                    float fromeX = CGRectGetMinX(_currentBtn.titleLabel.frame);
                    float toX = CGRectGetMinX(nextButton.titleLabel.frame);
                    frame.origin.x = _btnWidth * percent + fromeX + (toX - fromeX)* (1-newPercent);
                    frame.size.width = fromeWidth + (toWidth-fromeWidth)*(1-newPercent);
                    _indicatorView.frame = frame;
                }
            }else{
                if ((int)beginPercent==(int)percent) {
                    [_currentBtn setTitleColor:[UIColor colorWithTransformationFormColor:[self getCurrentButtonColor] toColor:self.titleColor percent:newPercent] forState:UIControlStateNormal];
                    [nextButton setTitleColor:[UIColor colorWithTransformationFormColor:self.titleColor toColor:[self getButtonColorAtIndex:(int)nextButton.tag] percent:newPercent] forState:UIControlStateNormal];
                    if (_style == GZCSegmentControlStyleLine&&newPercent>0&&newPercent<1) {
                        float fromeWidth = CGRectGetWidth(_currentBtn.titleLabel.frame);
                        float toWidth = CGRectGetWidth(nextButton.titleLabel.frame);
                        float fromeX = CGRectGetMinX(_currentBtn.titleLabel.frame);
                        float toX = CGRectGetMinX(nextButton.titleLabel.frame);
                        frame.origin.x = _btnWidth * percent + fromeX + (toX - fromeX)* newPercent;
                        frame.size.width = fromeWidth + (toWidth-fromeWidth)*newPercent;
                        _indicatorView.frame = frame;
                    }
                }
            }
        }
    }
    _isSelectedBegan = NO;
    lastPercent = percent;
}

@end
