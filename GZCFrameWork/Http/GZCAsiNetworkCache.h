//
//  GZCAsiNetworkCache.h
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/7/26.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZCAsiNetworkCache : NSObject

/**
 *  缓存数据
 *
 *  @param fileName 缓存数据的文件名
 *
 *  @param data 需要缓存的二进制
 */
+ (void)cacheForData:(NSData *)data fileName:(NSString *)fileName;

/**
 *  取出缓存数据
 *
 *  @param fileName 缓存数据的文件名
 *
 *  @return 缓存的二进制数据
 */
+ (NSData *)getCacheFileName:(NSString *)fileName;

/**
 *  判断缓存文件是否过期
 */
+ (BOOL)isExpire:(NSString *)fileName;

/**
 *  获取缓存的大小
 *
 *  @return 缓存的大小  单位是B
 */
+ (NSUInteger)getSize;

/**
 *  清除缓存
 */
+ (void)clearCache;

@end
