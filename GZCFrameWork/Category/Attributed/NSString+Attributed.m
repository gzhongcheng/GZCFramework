//
//  NSString+Attributed.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/9/12.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSString(Attributed)

- (BOOL)containString:(NSString*)body
{
    return [self rangeOfString:body].length > 0;
}

-(NSMutableAttributedString *)attributedWithColor:(UIColor *)color string:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    while (range.length) {
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
        NSString *subStr = [self substringFromIndex:range.length + range.location];
        range = [subStr rangeOfString:string];
    }
    return str;
}

-(NSMutableAttributedString *)attributedWithFont:(UIFont *)font string:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    while (range.length) {
        [str addAttribute:NSFontAttributeName value:font range:range];
        NSString *subStr = [self substringFromIndex:range.length + range.location];
        range = [subStr rangeOfString:string];
    }
    return str;
}

-(NSMutableAttributedString *)attributedWithStrikeout:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    while (range.length) {
        [str addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        NSString *subStr = [self substringFromIndex:range.length + range.location];
        range = [subStr rangeOfString:string];
    }
    return str;
}

-(NSMutableAttributedString *)attributedWithHandle:(NSArray<StringAttributeHandle *> *)handles{
    NSMutableAttributedString *attributedString = nil;
    if (self) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        for (StringAttributeHandle *handle in handles) {
            [attributedString addAttribute:[handle attributeName]
                                     value:[handle attributeValue]
                                     range:[handle effectRange]];
        }
    }
    return attributedString;
}

-(NSMutableAttributedString *)attributedWithLineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [self length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

@end
