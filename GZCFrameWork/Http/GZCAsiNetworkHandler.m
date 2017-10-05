//
//  GZCAsiNetworkHandler.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCAsiNetworkHandler.h"
#import "GZCAsiNetworkItem.h"
#import "AFNetworking.h"
#import "GZCAsiNetworkDelegate.h"
#import "UtilsMacros.h"

@interface GZCAsiNetworkHandler ()
<GZCAsiNetworkDelegate>
@end;
@implementation GZCAsiNetworkHandler

+ (GZCAsiNetworkHandler *)sharedInstance
{
    static GZCAsiNetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[GZCAsiNetworkHandler alloc] init];
    });
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkState = AFNetworkReachabilityStatusNotReachable;
    }
    return self;
}

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
                failureBlock:(GZCAsiFailureBlock)failureBlock
{
    /// 如果有一些公共处理，可以写在这里
    NSUInteger hashValue = [delegate hash];
    self.netWorkItem = [[GZCAsiNetworkItem alloc]initWithtype:networkType url:url params:params type:type delegate:delegate target:target action:action hashValue:hashValue successBlock:successBlock failureBlock:failureBlock cache:useCache];
    self.netWorkItem.delegate = self;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        [GZCAsiNetworkHandler sharedInstance].networkState = status;
//        switch (status)
//        {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                GZCLog(@"未知网络");
//                [GZCAsiNetworkHandler sharedInstance].networkError = NO;
//                break;
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                [GZCAsiNetworkHandler sharedInstance].networkError = YES;
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                GZCLog(@"手机自带网络");
//                [GZCAsiNetworkHandler sharedInstance].networkError = NO;
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                GZCLog(@"WIFI");
//                [GZCAsiNetworkHandler sharedInstance].networkError = NO;
//                break;
//        }
    }];
    [mgr startMonitoring];
}

/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    GZCAsiNetworkHandler *handler = [GZCAsiNetworkHandler sharedInstance];
    [handler.items removeAllObjects];
    handler.netWorkItem = nil;
}

- (void)netWorkWillDealloc:(GZCAsiNetworkItem *)itme
{
    [self.items removeObject:itme];
    self.netWorkItem = nil;
}
@end
