//
//  GZCWebViewController.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCWebViewController.h"
#import <WebKit/WebKit.h>
#import "AFNetworking.h"
#import "ProjectMacros.h"
#import "URLMacros.h"
#import "GZCAlertView.h"
#import "SDAutoLayout.h"

@interface GZCWebViewController()<GZCWebViewDelegate,UIActionSheetDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation GZCWebViewController{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showsNavigationBar = YES;
        self.shouldLontTapImage = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.gzcWebView stopLoading];
}

- (void)configUI {
    self.showsBack = YES;
    
    // 导航栏的菜单按钮
    UIImage *menuImage = [[UIImage imageNamed:@"gzc_webview_menu"]reSizeToSize:CGSizeMake(5, 20)];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleView.width - 40, 20, 30, 44)];
    [menuBtn setTintColor:NAVBAR_TITLE_COLOR];
    [menuBtn setImage:menuImage  forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:menuBtn];
    
    NSArray *cookies = [self getCookies];
    [self setWebCookies:cookies url:[NSURL URLWithString:API_HOST]];
}

#pragma mark - setter
-(void)setShowsNavigationBar:(BOOL)showsNavigationBar{
    _showsNavigationBar = showsNavigationBar;
    if (showsNavigationBar) {
        self.titleView.hidden = NO;
        self.contentView.frame = self.view.bounds;
        self.gzcWebView.frame = self.contentView.bounds;
    }else{
        self.titleView.hidden = YES;
        float offsetY = kApplication.statusBarHidden ? 0 : 20;
        self.contentView.y = offsetY;
        self.contentView.height = KScreenHeight - offsetY;
        self.gzcWebView.frame = self.contentView.bounds;
    }
}

-(void)setShouldLontTapImage:(BOOL)shouldLontTapImage{
    _shouldLontTapImage = shouldLontTapImage;
    self.gzcWebView.shouldLontTapImage = shouldLontTapImage;
}

-(void)setHomeUrl:(NSURL *)homeUrl{
    _homeUrl = homeUrl;
    NSArray *cookies = [self getCookies];
    [self setWebCookies:cookies url:[NSURL URLWithString:API_HOST]];
    [self.gzcWebView loadURL:_homeUrl withCookie:self.cookie];
}

-(GZCWebView *)gzcWebView{
    if (_gzcWebView == nil) {
        NSArray *cookies = [self getCookies];
        GZCWebView *gzcwebview = [[GZCWebView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height) cookie:cookies controller:self];
        gzcwebview.delegate = self;
        [self.contentView addSubview:gzcwebview];
        _gzcWebView = gzcwebview;
    }
    return _gzcWebView;
}

#pragma mark - 自定义事件

-(void)reload{
    [self.gzcWebView reload];
}

-(void)goBack{
    if (![self.gzcWebView canGoBack]) {
        if (self.navigationController!=nil) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)addUserAgent:(NSString *)name{
    [self.gzcWebView addUserAgent:name];
}

-(void)loadUrl:(NSString *)urlStr{
    [self.gzcWebView loadURLString:urlStr withCookie:self.cookie];
}

#pragma mark - 构建带cookie的request
- (void)setWebCookies:(NSArray *)cookies url:(NSURL *)url{
    [self.gzcWebView updateCookie:cookies url:url];
}

-(void)getWebCookies:(void (^)(id))completionHandler{
    [self.gzcWebView getCookieDictionary:completionHandler];
}

- (NSArray *)getCookies{
    NSMutableArray *cookies = [NSMutableArray array];
    NSHTTPCookieStorage *cookieStorage =[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSString *key in [self.cookie allKeys]) {
        NSDictionary *properties = [[NSMutableDictionary alloc] init];
        [properties setValue:[self.cookie objectForKey:key] forKey:NSHTTPCookieValue];
        [properties setValue:key forKey:NSHTTPCookieName];
        [properties setValue:@"" forKey:NSHTTPCookieDomain];
        [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
        [properties setValue:@"/" forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
        [cookies addObject:cookie];
        [cookieStorage setCookie:cookie];
    }
    return cookies;
}

- (void)clearCookies{
    [self.gzcWebView clearCookie:_homeUrl];
}

-(NSArray *)getAllCookies{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieAry = [cookieJar cookies];
    return cookieAry;
}

-(void)getCookieString:(void (^)(NSString *))completionHandle{
    [self.gzcWebView getCookieString:completionHandle];
}

-(NSString *)getUrlString{
    return [[self.gzcWebView getURL]absoluteString];
}

-(void)getCapture:(void (^)(UIImage *))completionHandler{
    [self.gzcWebView getCapture:completionHandler];
}

#pragma mark - 普通按钮事件

// 返回按钮点击
- (void)backBtnPressed:(id)sender {
    [self goBack];
}

// 菜单按钮点击
- (void)menuBtnPressed:(id)sender {
    [GZCAlertView showActionSheetWithTitle:nil buttons:@[@{
                                                         @"title":@"safari打开",
                                                         @"title_color" : @"333333"
                                                       },
                                                     @{
                                                         @"title":@"复制链接",
                                                         @"title_color" : @"333333"
                                                         },
                                                     @{
                                                         @"title":@"分享",
                                                         @"title_color" : @"333333"
                                                         },
                                                     @{
                                                         @"title":@"刷新",
                                                         @"title_color" : @"333333"
                                                         },
                                                     @{
                                                         @"title":@"关闭浏览器",
                                                         @"title_color" : @"333333"
                                                         }] block:^(NSInteger index, NSString *title) {
        NSString *urlStr = [self.gzcWebView getURL].absoluteString;
        if (index == 0) {
            // safari打开
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }else if (index == 1) {
            // 复制链接
            if (urlStr.length > 0) {
                [[UIPasteboard generalPasteboard] setString:urlStr];
                [self showAlertMessage:@"已复制链接到黏贴板"];
            }
        }else if (index == 2) {
            // 分享
            [self shareTaped];
        }else if (index == 3) {
            // 刷新
            [self reload];
        }else if (index == 4) {
            [self colseBtnPressed:nil];
        }
    }];
}

// 关闭按钮点击
- (void)colseBtnPressed:(id)sender {
    if (self.navigationController!=nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//分享按钮点击，子类中实现
- (void)shareTaped{
    
}

//分享链接
- (void)shareUrl:(NSString *)shareUrl{
    
}

#pragma mark - 菜单按钮事件

+(void)deleteWebCache{
    [GZCWebView deleteWebCache];
}

#pragma mark - gzcwebview delegate
- (void)GZCwebViewDidStartLoad:(GZCWebView *)webview
{
    GZCLog(@"页面开始加载");
}

- (BOOL)GZCwebView:(GZCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL
{
    GZCLog(@"截取到URL：%@",URL);
    return YES;
}
- (void)GZCwebView:(GZCWebView *)webview didFinishLoadingURL:(NSURL *)URL
{
    GZCLog(@"页面加载完成 %@",URL.absoluteString)
    self.titleString = [webview getWebTitle];
}

- (void)GZCwebView:(GZCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
    GZCLog(@"加载出现错误");
}

-(void)GZCWebView:(GZCWebView *)webview didSavedImage:(NSString *)savedMessage{
    [self showAlertMessage:savedMessage];
}

-(void)GZCWebView:(GZCWebView *)webview didLongTapShared:(NSString *)imageUrl{
    [self shareUrl:imageUrl];
}

@end
