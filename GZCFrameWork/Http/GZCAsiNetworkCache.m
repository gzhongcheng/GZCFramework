//
//  GZCAsiNetworkCache.m
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/7/26.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCAsiNetworkCache.h"
#import "GZCAsiNetworkDefine.h"
#import "NSString+encryption.h"
#import "NSDate+Utils.h"

@implementation GZCAsiNetworkCache

+ (void)cacheForData:(NSData *)data fileName:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[fileName md5String]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data writeToFile:path atomically:YES];
    });
}

+ (NSData *)getCacheFileName:(NSString *)fileName
{
    if ([self isExpire:fileName]) {
        return nil;
    }
    NSString *path = [kCachePath stringByAppendingPathComponent:[fileName md5String]];
    return [[NSData alloc] initWithContentsOfFile:path];
}

+ (NSUInteger)getAFNSize
{
    NSUInteger size = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}

+ (NSUInteger)getSize
{
    //获取AFN的缓存大小
    NSUInteger afnSize = [self getAFNSize];
    return afnSize;
}

+ (void)clearAFNCache
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        
        [fm removeItemAtPath:filePath error:nil];
        
    }
}

+ (void)clearCache
{
    [self clearAFNCache];
}

+ (BOOL)isExpire:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[fileName md5String]];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attributesDict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *fileModificationDate = attributesDict[NSFileModificationDate];
    return ([fileModificationDate secondsFromNow]>kGZCCacheExpireTime);
}


@end
