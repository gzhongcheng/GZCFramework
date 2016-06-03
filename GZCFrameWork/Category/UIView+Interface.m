//
//  UIView+Interface.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "UIView+Interface.h"

@implementation UIView(Interface)

+(instancetype)instanceViewWithNibName:(NSString *)nibName{
    NSArray* nibView=[[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

+(instancetype)instanceViewWithBoundle:(NSBundle *)bundle nibName:(NSString *)nibName{
    NSArray* nibView=[bundle loadNibNamed:nibName owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
