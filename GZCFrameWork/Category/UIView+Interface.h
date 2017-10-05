//
//  UIView+Interface.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Interface)

+(instancetype)instanceViewWithNibName:(NSString*)nibName;

+(instancetype)instanceViewWithBoundle:(NSBundle*)bundle nibName:(NSString*)nibName;

@end
