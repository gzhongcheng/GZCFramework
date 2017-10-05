//
//  NSDictory+AppendSignString.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/7/30.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "NSDictionary+AppendSignString.h"

@implementation NSDictionary(AppendSignString)

-(NSString*)appendSignedString{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [self allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        [contentString appendFormat:@"%@=%@&", categoryId, [self valueForKey:categoryId]];
    }
    NSString *resultString = [contentString substringToIndex:contentString.length-1];
    return resultString;
}

@end
