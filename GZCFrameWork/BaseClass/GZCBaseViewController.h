//
//  GZCBaseViewController.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//
//  viewcontroller基类，添加了一些常用功能

#import <UIKit/UIKit.h>
#import "GZCVCBaseViewConfig.h"
#import "GCD.h"
#import "UtilsMacros.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"

@interface GZCBaseViewController : UIViewController

extern NSString * const titleViewId;
extern NSString * const contentViewId;
extern NSString * const backgroundViewId;

/**
 是否首次加载
 */
@property (nonatomic,assign) BOOL isFistTime;

/**
 标题字符串（直接用title可能会让tabbar显示的不是我们想要的）
 */
@property (nonatomic,copy) NSString *titleString;

/**
 三个view的层级如下：
                view                frame
 ----------------------------------------------------------------------------------
 上层          titleView          CGRectMake(0,0,ScreenWidth,64)
 上层          contentView        CGRectMake(0,0,ScreenWidth,(ScreenHeight - 64))
 底层          backgroundView     CGRectMake(0,0,ScreenWidth,ScreenHeight)
 */
@property (nonatomic, strong) UIView           *titleView;
@property (nonatomic, strong) UIView           *contentView;
@property (nonatomic, strong) UIView           *backgroundView;

/**
 设置滑动返回的监听，只有当这个ViewController是UINavigationController的rootViewController时才能调用这个方法，否则会出问题。
 */
- (void)useInteractivePopGestureRecognizer;

/**
 设置是否支持滑动返回，只有当ViewController是被Push到UINavigationController中时生效
 */
@property (nonatomic)  BOOL  enableInteractivePopGestureRecognizer;

/**
 当ViewController是被Push到UINavigationController中时，使用这个方法进行pop到上一个视图

 @param animated 是否使用动画
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 当ViewController是被Push到UINavigationController中时，使用这个方法进行pop到根视图

 @param animated 是否使用动画
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated;


- (void)pushViewControllerNamed:(NSString*)className
               withOutBackTitle:(BOOL)hideBackTitle;

- (void)pushViewControllerWithOutBackTitle:(UIViewController*)controller;

-(void)presentViewControllerNamed:(NSString *)className;

-(void)tabbarSelectedIndex:(NSInteger)index;

#pragma mark - 子类中重写.

/**
 重新设置各个容器的属性
 
 @param viewsConfig Configs
 */
- (void)makeViewsConfig:(NSMutableDictionary <NSString *, GZCVCBaseViewConfig *> *)viewsConfig;

/**
 在这个方法中，设置titleView、contentView容器，如添加标题等
 */
- (void)setupSubViews;

#pragma mark - 弹出提示信息
/**
 类似Android中的Toast效果的提示框

 @param message 提示信息
 @param display 显示时间
 */
-(void)showMessage:(NSString*)message
       displayTime:(float)display;
-(void)showMessage:(NSString*)message;

/**
 MBProgressHUD加载动画

 @param message 提示信息
 */
-(void)showLodingMessage:(NSString *)message;
-(void)hideMessage;
-(void)showError:(NSString *)message;
-(void)showSuccess:(NSString *)message;

/**
 Alert提示框

 @parma title  提示头文字
 @param message 提示信息
 @param doneStr 确定按钮标题
 @param donehandler 确定按钮回调
 @param doneStyle 确定按钮风格 UIAlertActionStyleDestructive 字体为红色，UIAlertActionStyleCancel 字体为灰色，UIAlertActionStyleDefault 字体为浅蓝色
 @param cancelStr 取消按钮标题
 @param cancelhandler 取消按钮回调
 */
-(void)showAlertTitle:(NSString *)title
              message:(NSString *)message
           doneString:(NSString *)doneStr
          doneHandler:(void (^)())donehandler
            doneStyle:(UIAlertActionStyle)doneStyle
         cancelString:(NSString *)cancelStr
        cancelHandler:(void (^)())cancelhandler;

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
              doneStyle:(UIAlertActionStyle)doneStyle
           cancelString:(NSString *)cancelStr
          cancelHandler:(void (^)())cancelhandler;

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
           cancelString:(NSString *)cancelStr
          cancelHandler:(void (^)())cancelhandler;

-(void)showAlertMessage:(NSString *)message
             doneString:(NSString *)doneStr
            doneHandler:(void (^)())donehandler
           cancelString:(NSString *)cancelStr;

-(void)showAlertTitle:(NSString *)title
              message:(NSString *)message;

-(void)showAlertMessage:(NSString*)message;

//结束编辑，收起自定义弹出键盘等
-(void)endEditing:(BOOL)endediting;

@end
