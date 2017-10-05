//
//  GZCScrollLabelView.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/10.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import "GZCScrollLabelView.h"
#import "ProjectMacros.h"
#import "NSString+Size.h"

@interface GZCScrollLabel : UILabel

+ (instancetype)tx_label;

@end

@implementation GZCScrollLabel


-(void)setText:(NSString *)text{
    if ([text isKindOfClass:[NSAttributedString class]]) {
        [self setAttributedText:(NSAttributedString*)text];
        return;
    }
    [super setText:text];
}

+ (instancetype)tx_label {
    GZCScrollLabel *label = [[GZCScrollLabel alloc]init];
    label.numberOfLines = 2;
    label.font = SYSTEMFONT(14);
    label.textColor = mainBlackFontColor;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end

static const NSInteger GZCScrollDefaultTimeInterval = 2.0;//滚动默认时间间隔

@interface GZCScrollLabelView()

//显示文字的控件
@property (strong, nonatomic) GZCScrollLabel *upLabel;
@property (strong, nonatomic) GZCScrollLabel *downLabel;

@property (nonatomic,weak) GZCScrollLabel * showingLabel;  //当前显示的label
@property (nonatomic,weak) GZCScrollLabel * nextLabel;  //下一个显示的label
@property (nonatomic,assign) NSInteger scrolledIndex;  //当前显示的位置

@property (nonatomic,assign) BOOL   shouldSccrolling;  //是否应该滚动

@end

@implementation GZCScrollLabelView{
    BOOL scrolling;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    [self setSomePreference];
    [self setSomeSubviews];
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.upLabel.frame = self.bounds;
    self.downLabel.frame = CGRectMake(0, self.height , self.width, self.height);
}

#pragma mark - Preference Methods

- (void)setSomePreference {
    /** Default preference. */
    self.clipsToBounds = YES;
    self.scrollTimeInterval = GZCScrollDefaultTimeInterval;
    self.shouldSccrolling = NO;
    self.style = GZCScrollLabelStyleVertical;
}


- (void)setSomeSubviews {
    GZCScrollLabel *upLabel = [GZCScrollLabel tx_label];
    self.upLabel = upLabel;
    [self addSubview:upLabel];
    
    GZCScrollLabel *downLabel = [GZCScrollLabel tx_label];
    self.downLabel = downLabel;
    [self addSubview:downLabel];
}

-(void)setStyle:(GZCScrollLabelStyle)style{
    _style = style;
    switch (style) {
        case GZCScrollLabelStyleHorizontal:
            _upLabel.numberOfLines = 1;
            break;
        case GZCScrollLabelStyleVertical:
            break;
        default:
            break;
    }
}

-(void)setScrollString:(id)scrollString{
    _upLabel.text = scrollString;
    _upLabel.width = [scrollString sizeWithFont:_upLabel.font constrainedToSize:CGSizeMake(0, _upLabel.height)].width;
}

-(void)setScrollArray:(NSArray *)scrollArray{
    if ([_scrollArray isEqual:scrollArray]) {
        return;
    }
    _scrollArray = scrollArray;
    _showingLabel = _upLabel;
    _nextLabel = _downLabel;
    _showingLabel.frame = self.bounds;
    _nextLabel.frame = CGRectMake(0,  self.height , self.width , self.height );
    _showingLabel.text = self.scrollArray[0];
    _nextLabel.text = self.scrollArray[1];
    _scrolledIndex = 0;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _upLabel.textColor = textColor;
    _downLabel.textColor = textColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    _upLabel.font = textFont;
    _downLabel.font = textFont;
}

#pragma mark - animation Methods

-(void)startScrolling{
    switch (self.style) {
        case GZCScrollLabelStyleHorizontal:
        {
            if (self.shouldSccrolling) {
                return;
            }
            self.shouldSccrolling = YES;
            [self horizontalScroller];
            break;
        }
        case GZCScrollLabelStyleVertical:{
            if (self.shouldSccrolling) {
                return;
            }
            self.shouldSccrolling = YES;
            [self performSelector:@selector(scrollToNext) withObject:nil afterDelay:self.scrollTimeInterval];
            break;
        }
    }
}

-(void)stopScrolling{
    self.shouldSccrolling = NO;
}

- (void)horizontalScroller{
    if (scrolling) {
        return;
    }
    _upLabel.x = 0;
    if (_upLabel.width <= self.width) {
        return;
    }
    float duration = _upLabel.width / 50;
    scrolling = YES;
    [UIView animateWithDuration:duration delay:self.scrollTimeInterval options:UIViewAnimationOptionCurveLinear animations:^{
        _upLabel.x = self.width - _upLabel.width;
    } completion:^(BOOL finished) {
        scrolling = NO;
        if (self.shouldSccrolling) {
            [self performSelector:@selector(horizontalScroller) withObject:nil afterDelay:self.scrollTimeInterval];
        }
    }];
}

- (void)scrollToNext{
    _scrolledIndex ++;
    if (_scrolledIndex >= [self.scrollArray count]) {
        _scrolledIndex = 0;
    }
    [self scrollToIndex:_scrolledIndex];
    if (self.shouldSccrolling) {
        [self performSelector:@selector(scrollToNext) withObject:nil afterDelay:self.scrollTimeInterval];
    }
}

- (void)scrollToIndex:(NSInteger)index{
    if (index >= [self.scrollArray count]) {
        return;
    }
    [UIView animateWithDuration:0.25f animations:^{
        _showingLabel.y = - self.height;
        _nextLabel.y = 0;
    }completion:^(BOOL finished) {
        _showingLabel.y = self.height;
        _scrolledIndex = index;
        if (_showingLabel == _upLabel) {
            _nextLabel = _upLabel;
            _showingLabel = _downLabel;
        }else{
            _nextLabel = _downLabel;
            _showingLabel = _upLabel;
        }
        if (index+1 >= [self.scrollArray count]) {
            _nextLabel.text = self.scrollArray[0];
        }else{
            _nextLabel.text = self.scrollArray[index+1];
        }
    }];
}

-(void)dealloc{
    [_upLabel removeFromSuperview];
    [_downLabel removeFromSuperview];
    _upLabel = nil;
    _downLabel = nil;
}

@end
