//
//  GZCNetworkManager.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZCAsiNetworkDefine.h"
#import "GZCAsiNetworkDelegate.h"

@class GZCUploadParam;
/// 请求管理者
@interface GZCNetworkManager : NSObject

@property (nonatomic, assign) GZCHttpResponseType responseType;      //返回值格式

/// 返回单例
+(instancetype)sharedInstance;

#pragma mark - 取消网络请求
+(void)cancelAllRequest;

//+(void)cancelRequestWithMethod:(NSString *)method url:(NSString *)url;

#pragma mark - 发送 GET 请求的方法

/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param useCache      是否使用缓存
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
            successBlock:(GZCAsiSuccessBlock)successBlock
            failureBlock:(GZCAsiFailureBlock)failureBlock
                 useCache:(BOOL)useCache;
/**
 *   GET请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param useCache    是否使用缓存
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
                delegate:(id<GZCAsiNetworkDelegate>)delegate
                 useCache:(BOOL)useCache;
/**
 *   get 请求通过 taget 回调方法
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param action      action
 *   @param useCache    是否使用缓存
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
                  target:(id)target
                  action:(SEL)action
                 useCache:(BOOL)useCache;

#pragma mark - 发送 POST 请求的方法
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param useCache      是否使用缓存
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)paramsDict
              successBlock:(GZCAsiSuccessBlock)successBlock
              failureBlock:(GZCAsiFailureBlock)failureBlock
                   useCache:(BOOL)useCache;
/**
 *   post请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param useCache    是否使用缓存
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)paramsDict
                  delegate:(id<GZCAsiNetworkDelegate>)delegate
                  useCache:(BOOL)useCache;
/**
 *   post 请求通过 target 回调结果
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param useCache    是否使用缓存
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)paramsDict
                    target:(id)target
                    action:(SEL)action
                   useCache:(BOOL)useCache;
/**
 *  上传文件
 *
 *  @param url          上传文件的 url 地址
 *  @param paramsDict   参数字典
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *  @param showHUD      是否显示加载框
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)paramsDict
             successBlock:(GZCAsiSuccessBlock)successBlock
             failureBlock:(GZCAsiFailureBlock)failureBlock
              uploadParam:(GZCUploadParam *)uploadParam
                  showHUD:(BOOL)showHUD;

@end
