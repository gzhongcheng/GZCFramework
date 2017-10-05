//
//  GZCWebViewController.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCNormalTitleViewController.h"
#import "GZCWebView.h"

@interface GZCWebViewController : GZCNormalTitleViewController

@property (strong, nonatomic) NSURL *homeUrl;
@property (nonatomic, strong) NSDictionary * cookie;      //设置cookie
@property (strong, nonatomic) GZCWebView *gzcWebView;

@property (nonatomic, assign) BOOL showsNavigationBar;      //是否显示导航栏
@property (nonatomic,assign) BOOL shouldLontTapImage;  //长按图片是否显示选项,默认为no

- (void)addUserAgent:(NSString *)name;

-(void)shareTaped;

- (void)shareUrl:(NSString *)shareUrl;

-(void)reload;

-(void)goBack;

-(void)loadUrl:(NSString *)urlStr;

- (NSArray *)getCookies;

- (void)getWebCookies:(void (^)(id))completionHandler;

- (void)clearCookies;

-(NSArray *)getAllCookies;

-(void)getCookieString:(void (^)(NSString *cookieStr))completionHandle;

- (void)setWebCookies:(NSArray *)cookies url:(NSURL *)url;

-(NSString *)getUrlString;

-(void) getCapture:(void (^ )(UIImage * capture))completionHandler;

+ (void)deleteWebCache;

#pragma mark - webview的代理
- (void)GZCwebViewDidStartLoad:(GZCWebView *)webview;
- (BOOL)GZCwebView:(GZCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;
- (void)GZCwebView:(GZCWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)GZCwebView:(GZCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;

@end
