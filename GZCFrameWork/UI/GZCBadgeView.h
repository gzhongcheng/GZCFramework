//
//  GZCBadgeView.h
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/28.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//  角标

#import <UIKit/UIKit.h>

typedef enum {
    GZCBadgeViewAlignmentTopRight, //在图片的右上角显示（带字符串）
    GZCBadgeViewAlignmentRightCenter,//在cell的右侧中间显示（带字符串）
    GZCBadgeViewAlignmentTopRightWithoutNumber,//在图片的右上角显示（红点）
    GZCBadgeViewAlignmentRightCenterWithoutNumber//在cell的右侧中间显示（红点）
} GZCBadgeViewAlignment;

@interface GZCBadgeView : UIView

@property (nonatomic, copy) NSString *badgeText;

#pragma mark - Customization

@property (nonatomic, assign) GZCBadgeViewAlignment badgeAlignment;

@property (nonatomic, assign) CGFloat badgeHeight;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGSize badgeTextShadowOffset; //阴影偏移量
@property (nonatomic, strong) UIColor *badgeTextShadowColor;//阴影颜色
@property (nonatomic, strong) UIColor *badgeStrokeColor;    //边框
@property (nonatomic, assign) CGFloat badgeStrokeWidth;     //边框色
@property (nonatomic, assign) CGFloat badgeMarginToDrawInside;  //偏移量
@property (nonatomic, assign) CGFloat badgeTextSideMargin;      //四周留白
@property (nonatomic, assign) CGFloat marginToDrawInside;      //内部留白

@property (nonatomic, strong) UIFont *badgeTextFont;

@property (nonatomic, strong) UIColor *badgeBackgroundColor;

@property (nonatomic, strong) UIColor *badgeOverlayColor;

@property (nonatomic, assign) CGPoint badgePositionAdjustment;

@property (nonatomic, assign) CGRect frameToPositionInRelationWith;

- (id)initWithParentView:(UIView *)parentView alignment:(GZCBadgeViewAlignment)alignment;

- (void)setBadgeText:(NSString *)badgeText animation:(BOOL)animation;

@end
