//
//  GZCAsiNetworkItem.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZCAsiNetworkDefine.h"
#import "GZCAsiNetworkDelegate.h"

/**
 *  网络请求子项
 */
@interface GZCAsiNetworkItem : NSObject

/**
 *  网络请求方式
 */
@property (nonatomic, assign) GZCAsiNetWorkType networkType;

/**
 返回结果类型
 */
@property (nonatomic,assign) GZCHttpResponseType responseType;

/**
 *  网络请求URL
 */
@property (nonatomic, strong) NSString *url;

/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSDictionary *params;

/**
 *  网络请求的委托
 */
@property (nonatomic, assign) id<GZCAsiNetworkDelegate>delegate;

/**
 是否使用缓存
 */
@property (nonatomic,assign) BOOL useCache;

/**
 *   target
 */
@property (nonatomic,assign) id tagrget;
/**
 *   action
 */
@property (nonatomic,assign) SEL select;


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，并开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return GZCAsiNetworkItem对象
 */
- (GZCAsiNetworkItem *)initWithtype:(GZCAsiNetWorkType)networkType
                                url:(NSString *)url
                             params:(NSDictionary *)params
                               type:(GZCHttpResponseType)type
                           delegate:(id)delegate
                             target:(id)target
                             action:(SEL)action
                          hashValue:(NSUInteger)hashValue
                       successBlock:(GZCAsiSuccessBlock)successBlock
                       failureBlock:(GZCAsiFailureBlock)failureBlock
                              cache:(BOOL)useCache;



/**
 开始请求

 @param successBlock 请求成功后的block
 @param failureBlock 请求失败后的block
 */
- (void)beginRequestSuccessBlock:(GZCAsiSuccessBlock)successBlock
                    failureBlock:(GZCAsiFailureBlock)failureBlock;

/**
 请求成功后调用，解析返回结果

 @param responseObject 返回结果
 @param type 返回结果类型
 @param successBlock 调用请求成功的回调
 */
- (void)callSuccess:(id )responseObject
               type:(GZCHttpResponseType)type
       successBlock:(GZCAsiSuccessBlock )successBlock;

@end
