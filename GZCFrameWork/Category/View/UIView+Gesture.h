//
//  UIView+Gesture.h
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/8/18.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//
//  给View加上常用手势

#import <UIKit/UIKit.h>

@interface UIView(Gesture)


/**
 添加单击手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addTapGestureWithTarget:(id)target action:(SEL)action;

/**
 添加双击手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addDoubleTapGestureWithTarget:(id)target action:(SEL)action;

/**
 添加长按手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addLongTapGestureWithTarget:(id)target action:(SEL)action;

/**
 添加向左扫的手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addLeftSwipeGestureWithTarget:(id)target action:(SEL)action;

/**
 添加向右扫的手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addRightSwipeGestureWithTarget:(id)target action:(SEL)action;

/**
 添加向上扫的手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addUpSwipeGestureWithTarget:(id)target action:(SEL)action;

/**
 添加向下扫的手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addDownSwipeGestureWithTarget:(id)target action:(SEL)action;

/**
 添加平移手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addPanGestureWithTarget:(id)target action:(SEL)action;

/**
 添加捏合手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addPinchGestureWithTarget:(id)target action:(SEL)action;

/**
 添加旋转手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addRotationGestureWithTarget:(id)target action:(SEL)action;

/**
 添加屏幕边缘手势

 @param target 回调对象
 @param action 回调方法
 */
- (void)addScreenEdgePanGestureWithTarget:(id)target action:(SEL)action;

@end
