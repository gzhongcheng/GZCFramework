//
//  GZCNetworkManager.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCNetworkManager.h"
#import "GZCAsiNetworkHandler.h"
#import "GZCUploadParam.h"
#import "MBProgressHUD+Add.h"
#import "AFNetworking.h"
#import "UtilsMacros.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"

@implementation GZCNetworkManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static GZCNetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
        _manager.responseType = GZCHttpResponseType_Common;
    });
    return _manager;
}
/// 返回单例
+(instancetype)sharedInstance
{
    return [[super alloc] init];
}

#pragma mark - 取消网络请求
+(void)cancelAllRequest{
    [GZCAsiNetworkHandler cancelAllNetItems];
}

#pragma mark - GET 请求的三种回调方法

/**
 *   GET请求的公共方法 一下三种方法都调用这个方法 根据传入的不同参数觉得回调的方式
 *
 *   @param url           ur
 *   @param params   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param useCache      useCache
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
                  action:(SEL)action
                delegate:(id)delegate
            successBlock:(GZCAsiSuccessBlock)successBlock
            failureBlock:(GZCAsiFailureBlock)failureBlock
                 useCache:(BOOL)useCache
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[GZCAsiNetworkHandler sharedInstance] conURL:url networkType:GZCAsiNetWorkGET params:mutableDict type:[GZCNetworkManager sharedInstance].responseType delegate:delegate useCache:useCache target:target action:action successBlock:successBlock failureBlock:failureBlock];
}
/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param params   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param useCache      是否加载进度指示器
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
            successBlock:(GZCAsiSuccessBlock)successBlock
            failureBlock:(GZCAsiFailureBlock)failureBlock
                 useCache:(BOOL)useCache
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock useCache:useCache];
}
/**
 *   GET请求通过代理回调
 *
 *   @param url         url
 *   @param params  请求的参数
 *   @param delegate    delegate
 *   @param useCache    是否转圈圈
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                delegate:(id<GZCAsiNetworkDelegate>)delegate
                 useCache:(BOOL)useCache
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil useCache:useCache];
}

/**
 *   get 请求通过 taget 回调方法
 *
 *   @param url         url
 *   @param params  请求参数的字典
 *   @param target      target
 *   @param action      action
 *   @param useCache     是否加载进度指示器
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
                  action:(SEL)action
                 useCache:(BOOL)useCache
{
    [self getRequstWithURL:url params:params target:target action:action delegate:nil successBlock:nil failureBlock:nil useCache:useCache];
}

#pragma mark - POST请求的三种回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param params   params
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param useCache      useCache
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                  delegate:(id<GZCAsiNetworkDelegate>)delegate
              successBlock:(GZCAsiSuccessBlock)successBlock
              failureBlock:(GZCAsiFailureBlock)failureBlock
                   useCache:(BOOL)useCache
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[GZCAsiNetworkHandler sharedInstance] conURL:url networkType:GZCAsiNetWorkPOST params:mutableDict type:[GZCNetworkManager sharedInstance].responseType delegate:delegate useCache:useCache target:target action:action successBlock:successBlock failureBlock:failureBlock];
}
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param params    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param useCache       是否加载进度指示器
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
              successBlock:(GZCAsiSuccessBlock)successBlock
              failureBlock:(GZCAsiFailureBlock)failureBlock
                   useCache:(BOOL)useCache
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock useCache:useCache];
}
/**
 *   post请求通过代理回调
 *
 *   @param url         url
 *   @param params  请求的参数
 *   @param delegate    delegate
 *   @param useCache    是否转圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                  delegate:(id<GZCAsiNetworkDelegate>)delegate
                   useCache:(BOOL)useCache;
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil useCache:useCache];
}
/**
 *   post 请求通过 target 回调结果
 *
 *   @param url         url
 *   @param params  请求参数的字典
 *   @param target      target
 *   @param useCache     是否显示圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                   useCache:(BOOL)useCache
{
    [self postReqeustWithURL:url params:params target:target action:action delegate:nil successBlock:nil failureBlock:nil useCache:useCache];
}

/**
 *  上传文件
 *
 *  @param url          上传文件的 url 地址
 *  @param paramsDict   参数字典
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *  @param showHUD      显示 HUD
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)paramsDict
             successBlock:(GZCAsiSuccessBlock)successBlock
             failureBlock:(GZCAsiFailureBlock)failureBlock
              uploadParam:(GZCUploadParam *)uploadParam
                  showHUD:(BOOL)showHUD
{
    if (showHUD) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    GZCLog(@"上传图片接口 URL-> %@",url);
    GZCLog(@"上传图片的参数-> %@",paramsDict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        GZCLog(@"\n\n----请求加载中 %@\n",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:nil animated:YES];
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        GZCLog(@"----> %@",responseObject);
        if([GZCNetworkManager sharedInstance].responseType == GZCHttpResponseType_Common)
        {
            responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        else if ([GZCNetworkManager sharedInstance].responseType == GZCHttpResponseType_JqueryJson)
        {
            NSError* error = nil;
            NSString* result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString* r = nil;
            NSRange r1 = [result rangeOfString:@"("];
            if (r1.location == 0)
            {
                r = [result substringFromIndex:1];
                r = [[r substringToIndex:r.length - 1] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
            }
            else if(r1.length > 0)
            {
                r = [result substringFromIndex:r1.location+1];
                NSRange r2 = [r rangeOfString:@")"];
                r = [[r substringToIndex:r2.location] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
            }
            else
            {
                r = [result stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
            }
            responseObject = [NSDictionary dictionaryWithJSONString:r error:&error];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        GZCLog(@"----> %@",error.domain);
        if (error) {
            failureBlock(error);
        }
    }];
}

@end
