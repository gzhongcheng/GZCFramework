//
//  GZCAsiNetworkDefine.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#ifndef GZCAsiNetworkDefine_h
#define GZCAsiNetworkDefine_h

/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

/**
 缓存的有效期  单位:s
 */
#define kGZCCacheExpireTime (300)

/**
 *  返回结果类型
 */
typedef enum
{
    GZCHttpResponseType_JqueryJson,
    GZCHttpResponseType_Common
}GZCHttpResponseType;

/**
 *  请求类型
 */
typedef enum {
    GZCAsiNetWorkGET = 1,   /**< GET请求 */
    GZCAsiNetWorkPOST       /**< POST请求 */
} GZCAsiNetWorkType;

/**
 *  网络请求超时的时间
 */
#define GZCAsi_API_TIME_OUT 20


#if NS_BLOCKS_AVAILABLE
/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^GZCAsiStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^GZCAsiSuccessBlock)(NSObject *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^GZCAsiFailureBlock)(NSError *error);

#endif

#endif /* GZCAsiNetworkDefine_h */
