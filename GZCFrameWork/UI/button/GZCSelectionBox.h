//
//  GZCSelectionBox.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/21.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface GZCSelectionBox : UIButton

/**
 选中时的背景色
 */
@property (nonatomic,strong) UIColor * selectedColor;

/**
 为选中时的边框颜色
 */
@property (nonatomic,strong) UIColor * normalColor;

@end
