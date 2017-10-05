//
//  UIView+Interface.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/5/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//
//  根据xib文件实例化View

#import <UIKit/UIKit.h>

@interface UIView(Interface)

/**
 根据xib文件实例化View

 @param nibName View对应xib的文件名
 @return 实例化后的View
 */
+(instancetype)instanceViewWithNibName:(NSString*)nibName;

/**
 根据xib文件实例化View

 @param bundle View对应xib文件所在Bundle
 @param nibName View对应xib文件名
 @return 实例化后的View
 */
+(instancetype)instanceViewWithBoundle:(NSBundle*)bundle
                               nibName:(NSString*)nibName;

@end
