//
//  NSMutableAttributedString+Attributed.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttributeHandle.h"

@interface NSMutableAttributedString (Attributed)

/**
 添加富文本对象

 @param stringAttribute StringAttributeHandle对象
 */
- (void)addStringAttribute:(StringAttributeHandle *)stringAttribute;

/**
 消除指定的富文本对象

 @param stringAttribute StringAttributeHandle对象
 */
- (void)removeStringAttribute:(StringAttributeHandle *)stringAttribute;

@end
