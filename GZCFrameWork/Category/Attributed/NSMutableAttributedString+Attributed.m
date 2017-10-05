//
//  NSMutableAttributedString+Attributed.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "NSMutableAttributedString+Attributed.h"

@implementation NSMutableAttributedString (Attributed)

- (void)addStringAttribute:(StringAttributeHandle *)stringAttribute {
    [self addAttribute:[stringAttribute attributeName]
                 value:[stringAttribute attributeValue]
                 range:[stringAttribute effectRange]];
}

- (void)removeStringAttribute:(StringAttributeHandle *)stringAttribute {
    
    [self removeAttribute:[stringAttribute attributeName]
                    range:[stringAttribute effectRange]];
}

@end
