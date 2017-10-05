//
//  JxbAdPageView.h
//  JxbAdPageView
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/11.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JxbAdPageViewDelegate <NSObject>
- (void)click:(int)index;
@optional
- (void)onScroll:(int)index;
@end

@interface JxbAdPageView : UIView

@property(nonatomic,weak)id<JxbAdPageViewDelegate> delegate;

//圆点颜色
- (void)setPageTintColor:(UIColor*)tintColor;
//选中圆点颜色
- (void)setPageCurrentColor:(UIColor*)currentColor;
- (void)setAds:(NSArray*)imgNameArr;
@end
