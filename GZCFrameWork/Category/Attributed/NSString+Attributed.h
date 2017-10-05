//
//  NSString+Attributed.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/9/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StringAttributeHandle.h"

@interface NSString(Attributed)


/**
 判断是否包含某个字符串

 @param body 字符串
 @return 是否包含
 */
- (BOOL)containString:(NSString*)body;

/**
 改变指定字符串颜色

 @param color 目标颜色
 @param string 需要替换的字符串
 @return 变色后的NSMutableAttributedString字符串
 */
-(NSMutableAttributedString *)attributedWithColor:(UIColor *)color
                                           string:(NSString *)string;


/**
 改变指定字符串字体

 @param font 目标字体
 @param string 需要替换的字符串
 @return 变字体后的NSMutableAttributedString字符串
 */
-(NSMutableAttributedString *)attributedWithFont:(UIFont *)font
                                          string:(NSString *)string;


/**
 添加删除线

 @param string 需要添加删除线的文字
 @return 添加后的NSMutableAttributedString字符串
 */
-(NSMutableAttributedString *)attributedWithStrikeout:(NSString *)string;

/**
 根据配置数组来改变字体颜色等

 @param handles 配置数据
 @return 改变后的NSMutableAttributedString字符串
 */
-(NSMutableAttributedString *)attributedWithHandle:(NSArray <StringAttributeHandle *>*)handles;


/**
 改变行间距

 @param lineSpace 行间距
 @return 改变后的NSMutableAttributedString字符串
 */
-(NSMutableAttributedString *)attributedWithLineSpace:(CGFloat)lineSpace;



@end
