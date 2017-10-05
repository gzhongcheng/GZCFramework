//
//  GZCSegmentControl.h
//  XinYuanChi
//
//  Created by GuoZhongCheng on 16/2/25.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//  分段选择控件

#import <UIKit/UIKit.h>

@class GZCSegmentControl;

typedef NS_ENUM(NSInteger, GZCSegmentControlStyle) {
    GZCSegmentControlStyleRound,        //Default,圆角按钮
    GZCSegmentControlStyleLine,         //选中按钮下方显示横线
    GZCSegmentControlStyleNone          //只显示标题，选中变色
};

#pragma mark - GZCSegmentButton
@interface GZCSegmentButton : UIButton

@end


#pragma mark - GZCSegmentControlDelegate
@protocol GZCSegmentControlDelegate <NSObject>

/** 选中某个按钮时的代理回调 */
- (void)segmentControl:(GZCSegmentControl *)segment didSelectedIndex:(NSInteger)index;

@end

#pragma mark - GZCSegmentControl
@interface GZCSegmentControl : UIView

/**  按钮标题数组 */
@property (nonatomic, copy) NSArray *titles;
/**  按钮标题选中时的背景颜色*/
@property (nonatomic, copy) NSArray *selectedColors;
/**  按钮标题选中时的背景颜色*/
@property (nonatomic, copy) NSArray *selectedTitleColors;
/** 按钮圆角半径 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 指示视图的颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** 未选中时的按钮文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 选中时的按钮文字颜色 注：设置该值时，selectedTitleColors无效*/
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 按钮字体 */
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, weak) id<GZCSegmentControlDelegate> delegate;

@property (nonatomic, assign) GZCSegmentControlStyle style;

-(instancetype)initWithFrame:(CGRect)frame style:(GZCSegmentControlStyle)style;

/** 设置segment的索引为index的按钮处于选中状态 */
- (void)setSelectedIndex:(NSInteger)index;
- (void)setSelectedIndex:(NSInteger)index animation:(BOOL)animation;

- (void)setIndicatorViewPercent:(CGFloat)percent;

/** 选开始的设置 */
- (void)selectedBegan:(CGFloat)percent;

/** 选结束的设置 */
- (void)selectedEnd:(CGFloat)percent;
@end
