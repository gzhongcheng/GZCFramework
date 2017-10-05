//
//  GZCNumberChoiceView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/26.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCNumberChoiceView.h"
#import "GZCFramework.h"

@interface GZCNumberChoiceView()

@property (nonatomic, strong) UIButton * addButton;      //加号
@property (nonatomic, strong) UIButton * cutButton;      //减号
@property (nonatomic, strong) UILabel * numberLabel;      //数字显示

@end

@implementation GZCNumberChoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = mainLineColor.CGColor;
        self.layer.borderWidth = 1;
        self.maxNumber = 10;
        self.minNumber = 1;
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(self)-3];
        [_addButton setTitleColor:mainColor forState:UIControlStateNormal];
        [_addButton setTitleColor:mainLineColor forState:UIControlStateDisabled];
        [_addButton  setTitle:@"＋" forState:UIControlStateNormal];
        [_addButton addTarget: self action:@selector(addTaped) forControlEvents:UIControlEventTouchUpInside];
        _addButton.frame = CGRectMake(WIDTH(self)-HEIGHT(self), 0, HEIGHT(self), HEIGHT(self));
        [self addSubview:_addButton];
        
        _cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cutButton.titleLabel.font = [UIFont systemFontOfSize:HEIGHT(self)-3];
        [_cutButton setTitleColor:mainColor forState:UIControlStateNormal];
        [_cutButton setTitleColor:mainLineColor forState:UIControlStateDisabled];
        [_cutButton  setTitle:@"－" forState:UIControlStateNormal];
        [_cutButton addTarget: self action:@selector(cutTaped) forControlEvents:UIControlEventTouchUpInside];
        _cutButton.frame = CGRectMake(0, 0, HEIGHT(self), HEIGHT(self));
        [self addSubview:_cutButton];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxX(_cutButton), 0, MinX(_addButton)-MaxX(_cutButton), HEIGHT(self))];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:HEIGHT(self)-7];
        _numberLabel.textColor = mainFontColor;
        [self addSubview:_numberLabel];
        
        [self drawLineToFrame:CGRectMake(MaxX(_cutButton), 0, 1, HEIGHT(self))];
        [self drawLineToFrame:CGRectMake(MaxX(_numberLabel), 0, 1, HEIGHT(self))];
        
        self.number = 1;
    }
    return self;
}

-(void)addTaped{
    int old = [_numberLabel.text intValue];
    old ++;
    [self setNumber:old];
}

-(void)cutTaped{
    int old = [_numberLabel.text intValue];
    old --;
    [self setNumber:old];
}

-(void)setNumber:(int)number{
    BOOL shouldChange = YES;
    if ([self.delegate respondsToSelector:@selector(GZCNumberChoiceView:numberWillChange:)]) {
        shouldChange = [self.delegate GZCNumberChoiceView:self numberWillChange:number];
    }
    if (!shouldChange) {
        return;
    }
    _cutButton.enabled = YES;
    _addButton.enabled = YES;
    if (number<=_minNumber) {
        _cutButton.enabled = NO;
        number = _minNumber;
    }else if (number>=_maxNumber){
        _addButton.enabled = NO;
        number = _maxNumber;
    }
    _number = number;
    _numberLabel.text = [NSString stringWithFormat:@"%d",number];
}

@end
