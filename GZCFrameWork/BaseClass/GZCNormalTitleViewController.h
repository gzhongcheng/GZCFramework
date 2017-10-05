//
//  GZCNormalTitleViewController.h
//  GZCFramework
//
//  Created by ZhongCheng Guo on 2017/7/11.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//
//  带返回剪头和标题的viewcontroller

#import "GZCBaseViewController.h"

@interface GZCNormalTitleViewController : GZCBaseViewController

/**
 是否显示返回剪头,默认不显示
 */
@property (nonatomic,assign) BOOL showsBack;

/**
 是否显示Title，默认显示
 */
@property (nonatomic,assign) BOOL showsTitle;

/**
 设置Title字体颜色
 */
@property (nonatomic,strong) UIColor *titleColor;

@end
