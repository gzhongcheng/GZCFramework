//
//  GZCAlertHandle.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GZCAlertItem;
@interface GZCAlertHandle : NSObject

/**
 标题
 */
@property (nonatomic,strong) GZCAlertItem *title;

/**
 提示内容
 */
@property (nonatomic,strong) GZCAlertItem *message;

/**
 确定按钮
 */
@property (nonatomic,strong) GZCAlertItem *done;

/**
 取消按钮
 */
@property (nonatomic,strong) GZCAlertItem *cancel;

@end

@interface GZCAlertItem : NSObject

/**
 是否显示（如果不显示该元素，则设置为NO），默认为YES
 */
@property (nonatomic,assign) BOOL exist;

/**
 文本（可选），默认为空
 */
@property (nonatomic,  copy) NSString *text;

/**
 文本字体（可选）,默认为[UIFont systemFontOfSize:14]
 */
@property (nonatomic,strong) UIFont *font;

/**
 文本颜色（可选），默认为[UIColor darkGrayColor]
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 背景色（可选）
 */
@property (nonatomic,strong) UIColor *backgroundColor;

@end


