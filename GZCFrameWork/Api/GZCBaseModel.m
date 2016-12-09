//
//  GZCBaseModel.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/4.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCBaseModel.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"

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

+(instancetype)modelWithDic:(NSDictionary *)dic{
    return [self new];
}

+(id)dicWithJsonData:(NSData *)responseObject
                           error:(NSError **)error{
    NSString* result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//    NSString* r = nil;
//    NSRange r1 = [result rangeOfString:@"("];
//    if (r1.location == 0)
//    {
//        r = [result substringFromIndex:1];
//        r = [[r substringToIndex:r.length - 1] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//    }
//    else if(r1.length > 0)
//    {
//        r = [result substringFromIndex:r1.location+1];
//        NSRange r2 = [r rangeOfString:@")"];
//        r = [[r substringToIndex:r2.location] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//    }
//    else
//    {
//        r = [result stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//    }
    return [NSDictionary dictionaryWithJSONString:result error:error];
}

@end
