//
//  GZCBaseModel.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/4.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCBaseModel.h"

@implementation GZCBaseModel

-(instancetype)init{
    if (self = [super init]) {
        _identifier = [self uniqueIdentifier];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
