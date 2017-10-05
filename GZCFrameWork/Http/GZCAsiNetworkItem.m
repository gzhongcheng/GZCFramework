//
//  GZCAsiNetworkItem.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCAsiNetworkItem.h"
#import "AFNetworking.h"
#import "GZCAsiNetworkDefine.h"
#import "GZCAsiNetworkCache.h"
#import "UtilsMacros.h"
#import "TouchJSON/NSDictionary_JSONExtensions.h"
#import "GZCAsiNetworkHandler.h"

@interface GZCAsiNetworkItem ()

@end

@implementation GZCAsiNetworkItem


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
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
                              cache:(BOOL)useCache
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.responseType   = type;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.tagrget        = target;
        self.select         = action;
        self.useCache       = useCache;
        [self beginRequestSuccessBlock:successBlock
                          failureBlock:failureBlock];
    }
    return self;
}

- (void)beginRequestSuccessBlock:(GZCAsiSuccessBlock)successBlock
                    failureBlock:(GZCAsiFailureBlock)failureBlock{
    __weak typeof(self)weakSelf = self;
    //缓存数据的文件名
    NSString *fileName = [self fileName:_url params:_params];
    NSData *data = [GZCAsiNetworkCache getCacheFileName:fileName];
    if (data != nil) {
        if (_useCache) {
            [self callSuccess:data type:_responseType successBlock:successBlock];
            return;
        }
        if ([GZCAsiNetworkHandler sharedInstance].networkState == AFNetworkReachabilityStatusNotReachable||_useCache) {
            [self callSuccess:data type:_responseType successBlock:successBlock];
            return;
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (self.networkType == GZCAsiNetWorkGET)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [manager GET:_url parameters:_params progress:^(NSProgress * _Nonnull downloadProgress) {
            GZCLog(@"\n\n----请求加载中 %@\n",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (_useCache) {
                [GZCAsiNetworkCache cacheForData:responseObject fileName:fileName];
            }
            [self callSuccess:responseObject type:_responseType successBlock:successBlock];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            GZCLog(@"---error==%@\n",error.localizedDescription);
            if (failureBlock) {
                failureBlock(error);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                [weakSelf.delegate requestdidFailWithError:error];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
            [weakSelf removewItem];
        }];
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [manager POST:_url parameters:_params progress:^(NSProgress * _Nonnull uploadProgress) {
            GZCLog(@"\n\n----请求加载中 %@\n",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (_useCache) {
                [GZCAsiNetworkCache cacheForData:responseObject fileName:fileName];
            }
            [self callSuccess:responseObject type:_responseType successBlock:successBlock];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            GZCLog(@"---error==%@\n",error.localizedDescription);
            if (failureBlock) {
                failureBlock(error);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                [weakSelf.delegate requestdidFailWithError:error];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
            [weakSelf removewItem];
        }];
    }
}

- (void)callSuccess:(id  _Nullable)responseObject
               type:(GZCHttpResponseType)type
       successBlock:(GZCAsiSuccessBlock _Nullable)successBlock
{
    __weak typeof(self)weakSelf = self;
    NSString * response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    GZCLog(@"\n\n----请求的返回结果 %@\n",response);
    if(type == GZCHttpResponseType_Common)
    {
        responseObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    else
        if (type == GZCHttpResponseType_JqueryJson)
        {
            NSError* error = nil;
            NSString* result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseObject = [NSDictionary dictionaryWithJSONString:result error:&error];
        }
    if (successBlock) {
        successBlock(responseObject);
    }
    if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
        [weakSelf.delegate requestDidFinishLoading:responseObject];
    }
    [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
    [weakSelf removewItem];
}


/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.select]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (NSString *)fileName:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *mStr = [NSMutableString stringWithString:url];
    if (params != nil && [params count]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [mStr appendString:str];
        
    }
    return mStr;
}


@end
