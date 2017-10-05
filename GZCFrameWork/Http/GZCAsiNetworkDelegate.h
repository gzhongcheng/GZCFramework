//
//  GZCAsiNetworkDelegate.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZCAsiNetworkItem;

/**
 *   AFN 请求封装的代理协议
 */
@protocol GZCAsiNetworkDelegate <NSObject>

@optional

/**
 *   请求结束
 *
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoading:(NSDictionary*)returnData;
/**
 *   请求失败
 *
 *   @param error 失败的 error
 */
- (void)requestdidFailWithError:(NSError*)error;

/**
 *   网络请求项即将被移除掉
 *
 *   @param itme 网络请求项
 */
- (void)netWorkWillDealloc:(GZCAsiNetworkItem*)itme;

@end
