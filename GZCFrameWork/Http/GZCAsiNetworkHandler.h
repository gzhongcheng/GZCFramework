//
//  GZCAsiNetworkHandler.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZCAsiNetworkDefine.h"
@class GZCAsiNetworkItem;

/**
 *  网络请求Handler类
 */
@interface GZCAsiNetworkHandler : NSObject

/**
 *  单例
 *
 *  @return BMNetworkHandler的单例对象
 */
+ (GZCAsiNetworkHandler *)sharedInstance;

/**
 *  items
 */
@property(nonatomic,strong)NSMutableArray *items;

/**
 *   单个网络请求项
 */
@property(nonatomic,strong)GZCAsiNetworkItem *netWorkItem;

/**
 *  networkState
 */
@property(nonatomic,assign) NSInteger networkState;

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param useCache     是否使用缓存
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */
- (GZCAsiNetworkItem*)conURL:(NSString *)url
                 networkType:(GZCAsiNetWorkType)networkType
                      params:(NSMutableDictionary *)params
                        type:(GZCHttpResponseType)type
                    delegate:(id)delegate
                    useCache:(BOOL)useCache
                      target:(id)target
                      action:(SEL)action
                successBlock:(GZCAsiSuccessBlock)successBlock
                failureBlock:(GZCAsiFailureBlock)failureBlock;

/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;

/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems;
@end
