//
//  GZCTabBarController.h
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/28.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZCBadgeView.h"

@interface GZCTabBarButton : UIControl

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) GZCBadgeView *badgeView;

-(void)setImage:(UIImage*)image forState:(UIControlState)state;

-(void)setTitle:(NSString*)title forState:(UIControlState)state;

-(void)setTitleColor:(UIColor*)titleColor forState:(UIControlState)state;

-(void)setBadgeText:(NSString*)badgeText;

-(void)setBadgePoint;

-(void)hideBadge;

@end

@class GZCTabBar;

@protocol GZCTabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 *  返回值为bool型，用于设置是否选中对应按钮
 */
- (BOOL) tabBar:(GZCTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end


@interface GZCTabBar : UIView

@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,assign) BOOL translucent;
@property(nonatomic,weak) id<GZCTabBarDelegate> delegate;

-(void)addButtonWithImage:(UIImage *)image
            selectedImage:(UIImage *) selectedImage;

-(void)addButtonWithTitle:(NSString*)title
                    Image:(UIImage *)image
            selectedImage:(UIImage *) selectedImage;

-(void)addButtonWithTitle:(NSString*)title
         normalTitleColor:(UIColor*)normalColor
       selectedTitleColor:(UIColor*)selectedColor
                    Image:(UIImage *)image
            selectedImage:(UIImage *) selectedImage;

@end

@interface GZCTabBarController : UITabBarController

@property (nonatomic,strong) GZCTabBar *myTabBar;

@end
