//
//  GZCScrollLabelView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/10.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GZCScrollLabelStyle){
    GZCScrollLabelStyleHorizontal,  //走马灯效果
    GZCScrollLabelStyleVertical     //竖直
};

IB_DESIGNABLE

@interface GZCScrollLabelView : UIView

@property (nonatomic,assign) GZCScrollLabelStyle style;  //风格
@property (nonatomic,  copy) id scrollString;  //滚动的标题(可以是NSString或者NSAttributedString)，仅在 GZCScrollLabelStyleHorizontal 时生效
@property (nonatomic,strong) NSArray * scrollArray;  //滚动的标题(可以是NSString或者NSAttributedString)，仅在 GZCScrollLabelStyleVertical 时生效
@property (nonatomic,assign) IBInspectable CGFloat scrollTimeInterval;  //滚动时间间隔
@property (nonatomic,  copy) IBInspectable UIColor *textColor;  //文字颜色
@property (nonatomic,  copy) UIFont *textFont;  //字体

#pragma mark - Operation Methods
/**
 *  开始滚动
 */
- (void) startScrolling;
/**
 *  停止滚动
 */
- (void) stopScrolling;


@end
