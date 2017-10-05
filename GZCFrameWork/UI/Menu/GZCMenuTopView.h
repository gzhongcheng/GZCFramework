//
//  GZCMenuTopView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/8.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZCMenuTopView;
@class GZCMenuTopButton;
@protocol GZCMenuTopViewDelegate <NSObject>

@optional
-(void)GZCMenuTopView:(GZCMenuTopView*)topView
       buttonSelected:(GZCMenuTopButton*)button
              atIndex:(NSInteger)index;

-(BOOL)GZCMenuTopViewShouldChangeColor:(GZCMenuTopView*)topView
                        buttonSelected:(GZCMenuTopButton*)button
                               atIndex:(NSInteger)index;

-(BOOL)GZCMenuTopViewShouldRotate:(GZCMenuTopView*)topView
                        buttonSelected:(GZCMenuTopButton*)button
                               atIndex:(NSInteger)index;

@end

@interface GZCMenuTopButton : UIControl

@property (nonatomic, copy) NSString *title;     //标题
@property (nonatomic, strong) UILabel * titleLabel;      //标题
@property (nonatomic, strong) UIImageView * icon_ImageView;      //图标（文字前面）
@property (nonatomic, strong) UIImageView * down_ImageView;      //下拉图标（文字后面）,默认图片arrow_down_gary.png

@property (nonatomic, assign) BOOL shouldRotateWhenSelected;      //选中时是否旋转下拉图标

//以下state全部只用到UIControlStateNormal和UIControlStateSelected
-(void)setIconImage:(UIImage *)image forState:(UIControlState)state;

-(void)setDownImage:(UIImage *)image forState:(UIControlState)state;

-(void)setTItleColor:(UIColor *)color forState:(UIControlState)state;

-(void)setSelected:(BOOL)selected changedColor:(BOOL)changeColor;

-(void)setSelected:(BOOL)selected changedColor:(BOOL)changeColor rotated:(BOOL)rotated;

@end

@interface GZCMenuTopView : UIView

@property (nonatomic, strong) NSMutableArray <__kindof GZCMenuTopButton*>* buttons;      //按钮

@property (nonatomic, strong) CALayer * topLine;        //顶部分割线
@property (nonatomic, strong) CALayer * bottomLine;     //底部分割线
@property (nonatomic, strong) UIColor * lineColor;      //分割线颜色
@property (nonatomic, assign) BOOL showContentLines;      //是否显示中间的分割线,默认YES
@property (nonatomic, assign) NSInteger selectedIndex;      //已选中的按钮位置

@property (nonatomic,weak)   id<GZCMenuTopViewDelegate> delegate;

-(void)addMenuIcon:(NSString *)title;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
         iconImage:(UIImage *)iconImage;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
         downImage:(UIImage *)downImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
         iconImage:(UIImage *)iconImage
         downImage:(UIImage *)downImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
         downImage:(UIImage *)downImage
 downSelectedImage:(UIImage *)downSelectedImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
         iconImage:(UIImage *)iconImage
 iconSelectedImage:(UIImage *)iconSelectedImage;

-(void)addMenuIcon:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
         iconImage:(UIImage *)iconImage
 iconSelectedImage:(UIImage *)iconSelectedImage
         downImage:(UIImage *)downImage
 downSelectedImage:(UIImage *)downSelectedImage
shouldRotateWhenSelected:(BOOL)shouldRotateWhenSelected;

-(void)setTitle:(NSString *)title
        toIndex:(NSInteger)index;

-(void)setSelected:(BOOL)selected
           toIndex:(NSInteger)index;

@end
