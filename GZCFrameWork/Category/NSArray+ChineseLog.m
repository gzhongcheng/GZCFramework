//
//  NSArray+ChineseLog.m
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/2/16.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "NSArray+ChineseLog.h"

@implementation NSArray (ChineseLog)

- (NSString*)descriptionWithLocale:(id)locale {
    NSMutableString*str = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL*stop) {
        [str appendFormat:@"\t%@,\n", obj];
    }];
    [str appendString:@")"];
    return str;
}

@end

@implementation NSDictionary(ChineseLog)

- (NSString*)descriptionWithLocale:(id)locale {
    NSMutableString*str = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL*stop) {
        [str appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [str appendString:@"}\n"];
    return str;
}

@end
