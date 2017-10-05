//
//  GZCBaseModel.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/5/4.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCBaseModel.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"
#import "GZCNetwork.h"

@implementation GZCBaseModel

-(instancetype)init{
    if (self = [super init]) {
        _identifier = [self uniqueIdentifier];
    }
    return self;
}

+(NSDictionary *)getDictionaryFromJsonFileNamed:(NSString *)fileName{
    NSError*error;
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    NSString* jresult = [[NSString alloc] initWithData:jdata encoding:NSUTF8StringEncoding];
    id resdic = [NSDictionary dictionaryWithJSONString:jresult error:&error];
    return resdic;
}

//产生不重复的identifier
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
    return [NSDictionary dictionaryWithJSONString:result error:error];
}


+(void)cancelHTTPRequest{
    [GZCNetworkManager cancelAllRequest];
}

@end
