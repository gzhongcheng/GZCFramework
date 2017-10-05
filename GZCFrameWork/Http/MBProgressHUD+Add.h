//
//  MBProgressHUD+Add.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//
//  对MBProgressHUD的扩展

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Add)

/**
 显示错误信息到目标视图

 @param error 错误信息
 @param view 目标视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 显示成功信息到目标视图

 @param success 成功信息
 @param view 目标视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

@end
