//
//  NSString+Size.h
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.

//  获取文本size

#import <UIKit/UIKit.h>

@interface NSString (Size)


/**
 计算文本高度

 @param font 字体
 @param size 范围限制 如：限制宽度320,计算高度,传入 CGSizeMake(MAXFLOAT, 320)
 @return 文本高度
 */
- (CGFloat)heightWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size;


/**
 计算文本Size

 @param font 字体
 @param size 范围限制 如：限制宽度320,计算高度,传入 CGSizeMake(MAXFLOAT, 320)
 @return 文本Size
 */
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size;


/**
 计算文本SIze

 @param font 字体
 @param size 范围限制 如：限制宽度320,计算高度,传入 CGSizeMake(MAXFLOAT, 320)
 @param linespace 行间距
 @param lineBreakMode 超出范围的截取规则
 @return 文本size
 */
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
           lineSpacing:(CGFloat)linespace
         lineBreakMode:(NSLineBreakMode)lineBreakMode;


/**
 计算文本的Size

 @param string 字符串
 @param font 字体
 @param size 范围限制 如：限制宽度320,计算高度,传入 CGSizeMake(MAXFLOAT, 320)
 @return 文本Size
 */
+ (CGSize)getStringSize:(NSString*)string
                   font:(UIFont*)font
      constrainedToSize:(CGSize)size;

/**
 计算文本的Size
 如果在textview等控件中，默认左右都有5的padding，上下都有7的padding，需要自行加上
 或者用以下代码去除padding
 textView.textContainer.lineFragmentPadding = 0;
 textView.textContainerInset = UIEdgeInsetsZero;

 @param string 字符串
 @param font 字体
 @param size 最大范围
 @param linespace 行间距
 @param lineBreakMode 超出范围的截取规则
 @return 文本Size
 */
+ (CGSize)getStringSize:(NSString*)string
                   font:(UIFont*)font
      constrainedToSize:(CGSize)size
            lineSpacing:(CGFloat)linespace
          lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
