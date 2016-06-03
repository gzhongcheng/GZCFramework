//
//  GZCTextIconView.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/17.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  文字样式的标志

#import <UIKit/UIKit.h>

@interface GZCTextIconView : UILabel

-(instancetype)initWithFrame:(CGRect)frame
                        text:(NSString *)text
                     bgColor:(UIColor *)color;

@end
