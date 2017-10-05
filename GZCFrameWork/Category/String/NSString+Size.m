//
//  NSString+Size.m
//  GZCFramework
//
//  Created by GuoZhongCheng on 15/12/23.
//  Copyright © 2015年 GuoZhongCheng. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self sizeWithFont:font constrainedToSize:size].height;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [NSString getStringSize:self font:font constrainedToSize:size];
}

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineSpacing:(CGFloat)linespace lineBreakMode:(NSLineBreakMode)lineBreakMode{
    return [NSString getStringSize:self font:font constrainedToSize:size lineSpacing:linespace lineBreakMode:lineBreakMode];
}

+ (CGSize)getStringSize:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getStringSize:string font:font constrainedToSize:size lineSpacing:0 lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize)getStringSize:(NSString*)string font:(UIFont*)font constrainedToSize:(CGSize)size lineSpacing:(CGFloat)linespace lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize textSize;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespace];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        textSize = [string sizeWithAttributes:attributes];
    }
    else
    {
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（注：字体大小+行间距=行高）
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading ;
        CGRect rect = [string boundingRectWithSize:size
                                           options:option
                                        attributes:attributes
                                           context:nil];
        //向上取整可以减少误差
        textSize.height = ceilf(rect.size.height);
        textSize.width = ceilf(rect.size.width);
    }
    return textSize;
}

@end
