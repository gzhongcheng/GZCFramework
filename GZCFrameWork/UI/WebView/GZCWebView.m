//
//  GZCWebView.m
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/9/2.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCWebView.h"
#import "UIView+ScreenCapture.h"
#import "WKWebView+ScreenCapture.h"
#import "UserModel.h"
#import "SDWebImageDownloader.h"
#import "GZCAlertView.h"

#define isiOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0
#define progressTintColor [UIColor colorWithRed:0.400 green:0.863 blue:0.133 alpha:1.000]
static void *GZCWebBrowserContext = &GZCWebBrowserContext;

@interface GZCWebView ()<UIAlertViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@property (nonatomic, strong) NSURL *URLToLaunchWithPermission;
@property (nonatomic, strong) UIAlertView *externalAppPermissionAlertView;
/**
 WKWebview的cookie
 */
@property (nonatomic,strong) NSArray *wkCookies;

@end

@implementation GZCWebView{
    NSString *_saveImageUrl;
}

#pragma mark --Initializers
-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame cookie:nil controller:nil];
}

- (instancetype)initWithFrame:(CGRect)frame cookie:(NSArray <NSHTTPCookie *> *)cookie controller:(UIViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        self.controller = controller;
        if(isiOS8) {
            if ([cookie count]) {
                self.wkWebView = [[WKWebView alloc]initWithFrame:self.bounds configuration:[self getconfigurationWithCookies:cookie]];
            }else{
                self.wkWebView = [[WKWebView alloc] init];
            }
        }
        else {
            self.uiWebView = [[UIWebView alloc] init];
            
        }
        self.backgroundColor = [UIColor redColor];
        if(self.wkWebView) {
            [self.wkWebView setFrame:self.bounds];
            [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.wkWebView setNavigationDelegate:self];
            [self.wkWebView setUIDelegate:self];
            [self.wkWebView setMultipleTouchEnabled:YES];
            [self.wkWebView setAutoresizesSubviews:YES];
            [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
            self.wkWebView.allowsBackForwardNavigationGestures =YES;
            [self addSubview:self.wkWebView];
            self.wkWebView.scrollView.bounces = NO;
            [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:GZCWebBrowserContext];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(wkLongPressed:)];
            longPress.delegate = self;
            [self.wkWebView addGestureRecognizer:longPress];
        }
        else  {
            [self.uiWebView setFrame:self.bounds];
            [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            [self.uiWebView setDelegate:self];
            [self.uiWebView setMultipleTouchEnabled:YES];
            [self.uiWebView setAutoresizesSubviews:YES];
            [self.uiWebView setScalesPageToFit:YES];
            [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
            self.uiWebView.scrollView.bounces = NO;
            [self addSubview:self.uiWebView];
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(uiLongPressed:)];
            longPress.delegate = self;
            [self.uiWebView addGestureRecognizer:longPress];
        }
        
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
        [self.progressView setFrame:CGRectMake(0, 0, self.frame.size.width,3)];
        
        //设置进度条颜色
        [self setTintColor:progressTintColor];
        [self addSubview:self.progressView];
        
    }
    return self;
}



#pragma mark - Public Interface
-(void)updateCookie:(NSArray *)cookies url:(NSURL *)url{
    // 设置header，通过遍历cookies来一个一个的设置header
    for (NSHTTPCookie *cookie in cookies){
        // cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
        NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
                                    [NSDictionary dictionaryWithObject:
                                     [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
                                                                forKey:@"Set-Cookie"]
                                                                          forURL:url];
        // 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
                                                           forURL:url
                                                  mainDocumentURL:nil];
    }
    if (isiOS8) {
        if ([cookies count]) {
            NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
            WKUserContentController* userContentController = self.wkWebView.configuration.userContentController;
            WKUserScript * cookieScript = [[WKUserScript alloc]
                                           initWithSource:[NSString stringWithFormat:@"document.cookie ='%@';",[headers objectForKey:@"Cookie"]]
                                           injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                           forMainFrameOnly:NO];
            [userContentController addUserScript:cookieScript];
        }else{
            [self.wkWebView.configuration.userContentController removeAllUserScripts];
//            [self deleteWebCache];
        }
    }
}

+ (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        //// All kinds of data
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
        
    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
        
    }
}

-(void)addUserAgent:(NSString *)name{
    if (isiOS8) {
        [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            NSString *userAgent = result;
            NSString *newUserAgent = [userAgent stringByAppendingString:name];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            }];
        }];
    }else{
        NSString *oldAgent = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        NSString *newAgent = [oldAgent stringByAppendingString:name];
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }
}

-(NSString *)getWebTitle{
    NSString *title = @"";
    if (isiOS8) {
        title = self.wkWebView.title;
    }else{
        title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    return title;
}

-(void)reload{
    if (isiOS8){
        [self.wkWebView reload];
    }else{
        [self.uiWebView reload];
    }
}

-(BOOL)canGoBack{
    if (isiOS8) {
        if (self.wkWebView.canGoBack) {
            [self.wkWebView goBack];
            return YES;
        }else {
            return NO;
        }
    }else {
        if (self.uiWebView.canGoBack) {
            [self.uiWebView goBack];
            return YES;
        }else {
            return NO;
        }
    }
}

-(NSURL *)getURL{
    NSURL *url;
    if (isiOS8)
        url = self.wkWebView.URL;
    else
        url = self.uiWebView.request.URL;
    return url;
}

-(void)getCapture:(void (^)(UIImage *))completionHandler{
    if (isiOS8)
       [self.wkWebView captureCallback:^(UIImage *image) {
           completionHandler(image);
       }];
    else{
        UIImage *capture = [self.uiWebView capture];
        completionHandler(capture);
    }
}

-(void)clearCookie:(NSURL *)url{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieAry = [cookieJar cookies];
    for (cookie in cookieAry) {
        [cookieJar deleteCookie: cookie];
    }
    if (isiOS8) {
        [self updateCookie:nil url:url];
    }
}

-(void)getCookieString:(void (^)(NSString *))completionHandle{
    if(isiOS8){
        [self.wkWebView evaluateJavaScript:@"document.cookie" completionHandler:^(id _Nullable message, NSError * _Nullable error) {
            completionHandle(message);
        }];
    }else{
        NSString *message = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.cookie"];
        completionHandle(message);
    }
}

#pragma mark - loadUrl
//-(void)loadURLStringWithCookie:(NSString *)URLString{
//    NSURL *URL = [NSURL URLWithString:URLString];
//    [self loadURLWithCookie:URL];
//}
//
//-(void)loadURLWithCookie:(NSURL *)URL{
//    [self loadRequestWithCookie:[NSURLRequest requestWithURL:URL]];
//}
//
//-(void)loadRequestWithCookie:(NSURLRequest *)request{
//    [self loadRequest:request withCookie:[UserModel shareInstance].cookie];
//}

-(void)loadURL:(NSURL *)URL withCookie:(NSDictionary *)cookies{
    [self loadRequest:[NSURLRequest requestWithURL:URL] withCookie:cookies];
}

-(void)loadURLString:(NSString *)URLString withCookie:(NSDictionary *)cookies{
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL withCookie:cookies];
}

-(void)loadRequest:(NSURLRequest *)request withCookie:(NSDictionary *)cookies{
    if (self.cookies != cookies) {
        self.cookies = cookies;
    }
    if(self.wkWebView) {
        NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:request.URL];
        
        if (cookies == nil) {
            [self.wkWebView loadRequest:mrequest];
            return;
        }
        //获取原来的cookie
        [self getCookieString:^(NSString *cookieStr) {
            for (NSString *key in [cookies allKeys]) {
                //如果没有cookies中的值存在，就拼接上去
                if (cookieStr == nil) {
                    cookieStr = [NSString stringWithFormat:@"%@=%@",key,[cookies objectForKey:key]];
                }else
                if ([cookieStr rangeOfString:key].length == 0) {
                    cookieStr = [NSString stringWithFormat:@"%@;%@=%@",cookieStr,key,[cookies objectForKey:key]];
                }
            }
            //设置cookie到header
            [mrequest addValue:cookieStr forHTTPHeaderField:@"Cookie"];
            //打开请求
            [self.wkWebView loadRequest:mrequest];
        }];
    }
    else  {
        [self.uiWebView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadRequest:(NSURLRequest *)request {
    if(self.wkWebView) {
        [self.wkWebView loadRequest:request];
    }
    else  {
        [self.uiWebView loadRequest:request];
    }
}

- (void)loadHTMLString:(NSString *)HTMLString {
    if(self.wkWebView) {
        [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
    }
    else if(self.uiWebView) {
        [self.uiWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

- (void)stopLoading{
    if (self.wkWebView) {
        [self.wkWebView stopLoading];
    }else
    if (self.uiWebView) {
        [self.uiWebView stopLoading];
    }
}

#pragma mark - set

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.progressView setTintColor:tintColor];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
}

#pragma mark - cookie get
- (WKWebViewConfiguration *)getconfigurationWithCookies:(NSArray *)cookies{
    if ([cookies count]) {
        //写入cookie
        NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        WKUserContentController* userContentController = WKUserContentController.new;
        WKUserScript * cookieScript = [[WKUserScript alloc]
                                       initWithSource:[NSString stringWithFormat:@"document.cookie ='%@';",[headers objectForKey:@"Cookie"]]
                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                       forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        
        WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
        webViewConfig.userContentController = userContentController;
        return webViewConfig;
    }
    return nil;
}

-(void)getCookieDictionary:(void (^)(NSDictionary *cookieDic))completionHandler{
    [self getCookieString:^(NSString *cookieStr) {
        if ([cookieStr isKindOfClass:[NSString class]]) {
            NSArray * array = [cookieStr componentsSeparatedByString:@";"];
            NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
            for (NSString * str in array) {
                NSArray *kv = [str componentsSeparatedByString:@"="];
                if ([kv count]==2) {
                    NSString *key = [kv[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString *value = kv[1];
                    [cookies setValue:value forKey:key];
                }
            }
            completionHandler(cookies);
        }else{
            completionHandler(nil);
        }
    }];
//    if (self.wkWebView) {
//        [self.wkWebView evaluateJavaScript:@"document.cookie" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//            if ([response isKindOfClass:[NSString class]]) {
//                NSArray * array = [response componentsSeparatedByString:@";"];
//                NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
//                for (NSString * str in array) {
//                    NSArray *kv = [str componentsSeparatedByString:@"="];
//                    if ([kv count]==2) {
//                        NSString *key = [kv[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                        NSString *value = kv[1];
//                        [cookies setValue:value forKey:key];
//                    }
//                }
//                completionHandler(cookies);
//            }
//            else{
//                completionHandler(response);
//            }
//            
//        }];
//    }else{
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        NSArray *cookieAry = [cookieJar cookies];
//        NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
//        for (NSHTTPCookie *cookie in cookieAry){
//            [cookies setValue:cookie.value forKey:cookie.name];
//        }
//        completionHandler(cookies);
//    }
}

- (NSArray *)getCookies:(NSDictionary *)cookie{
    NSMutableArray *cookies = [NSMutableArray array];
    for (NSString *key in [cookie allKeys]) {
        NSDictionary *properties = [[NSMutableDictionary alloc] init];
        [properties setValue:[cookie objectForKey:key] forKey:NSHTTPCookieValue];
        [properties setValue:key forKey:NSHTTPCookieName];
        [properties setValue:@"" forKey:NSHTTPCookieDomain];
        [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
        [properties setValue:@"/" forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
        [cookies addObject:cookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    return cookies;
}

#pragma mark - target
- (void)uiLongPressed:(UILongPressGestureRecognizer*)recognizer
{
    if (!self.shouldLontTapImage||recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.uiWebView];
    
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.uiWebView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (urlToSave.length == 0) {
        return;
    }
    
    [self showImageOptionsWithUrl:urlToSave];
}

- (void)wkLongPressed:(UILongPressGestureRecognizer*)sender
{
    if (!self.shouldLontTapImage||sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [sender locationInView:self.wkWebView];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [self.wkWebView evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        [self showImageOptionsWithUrl:imgUrl];
    }];
}

-(void)showImageOptionsWithUrl:(NSString *)imgUrl{
    if (imgUrl) {
        _saveImageUrl = imgUrl;
        [GZCAlertView showActionSheetWithTitle:nil buttons:@[@{@"title":@"保存图片"},@{@"title":@"分享链接"}] block:^(NSInteger index, NSString *title) {
            switch (index) {
                case 0:
                {
                    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:_saveImageUrl] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        if (image==nil) {
                            if ([self.delegate respondsToSelector:@selector(GZCWebView:didSavedImage:)]) {
                                [self.delegate GZCWebView:self didSavedImage:@"保存图片失败！"];
                            }
                            return;
                        }
                        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                    }];
                }
                    break;
                case 1:
                {
                    if ([self.delegate respondsToSelector:@selector(GZCWebView:didLongTapShared:)]) {
                        [self.delegate GZCWebView:self didLongTapShared:_saveImageUrl];
                    }
                }
                default:
                    break;
            }
        }];
    }
}

#pragma mark - imageSaved
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message = @"图片已成功保存到相册！";
    if (error) {
        message = @"保存图片失败！";
    }
    if ([self.delegate respondsToSelector:@selector(GZCWebView:didSavedImage:)]) {
        [self.delegate GZCWebView:self didSavedImage:message];
    }
}



#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if(webView == self.uiWebView) {
        [self.delegate GZCwebViewDidStartLoad:self];
        
    }
}

//监视请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if(webView == self.uiWebView) {
        
        if(![self externalAppRequiredToOpenURL:request.URL]) {
            self.uiWebViewCurrentURL = request.URL;
            self.uiWebViewIsLoading = YES;
            
            [self fakeProgressViewStartLoading];
            
            
            //back delegate
            [self.delegate GZCwebView:self shouldStartLoadWithURL:request.URL];
            return YES;
        }
        else {
            [self launchExternalAppWithURL:request.URL];
            return NO;
        }
    }
    return NO;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
            
            [self fakeProgressBarStopLoading];
        }
        
        //back delegate
        [self.delegate GZCwebView:self didFinishLoadingURL:self.uiWebView.request.URL];
        
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if(webView == self.uiWebView) {
        if(!self.uiWebView.isLoading) {
            self.uiWebViewIsLoading = NO;
            
            [self fakeProgressBarStopLoading];
        }
        //back delegate
        [self.delegate GZCwebView:self didFailToLoadURL:self.uiWebView.request.URL error:error];
    }
}


#pragma mark - WKNavigationDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == self.wkWebView) {
        //back delegate
        [self.delegate GZCwebViewDidStartLoad:self];
        //        WKNavigationActionPolicy(WKNavigationActionPolicyAllow);
        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if(webView == self.wkWebView) {
        
        //back delegate
        [self.delegate GZCwebView:self didFinishLoadingURL:self.wkWebView.URL];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        //back delegate
        [self.delegate GZCwebView:self didFailToLoadURL:self.wkWebView.URL error:error];
    }
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(webView == self.wkWebView) {
        //back delegate
        [self.delegate GZCwebView:self didFailToLoadURL:self.wkWebView.URL error:error];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //读取wkwebview中的cookie 方法1
    for (NSHTTPCookie *cookie in cookies) {
        //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        NSLog(@"wkwebview中的cookie:%@", cookie);
        
    }
    //读取wkwebview中的cookie 方法2 读取Set-Cookie字段
    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSLog(@"wkwebview中的cookie:%@", cookieString);
    
    //看看存入到了NSHTTPCookieStorage了没有
    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
        NSLog(@"NSHTTPCookieStorage中的cookie%@", cookie);
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if(webView == self.wkWebView) {
        
        NSURL *URL = navigationAction.request.URL;
        if(![self externalAppRequiredToOpenURL:URL]) {
            if(!navigationAction.targetFrame) {
//                [self loadURLWithCookie:URL];
                [self loadRequest:navigationAction.request withCookie:self.cookies];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            NSString *path= URL.absoluteString;
            if ([path hasPrefix:@"sms:"] || [path hasPrefix:@"tel:"]) {
                UIApplication * app = [UIApplication sharedApplication];
                if ([app canOpenURL:[NSURL URLWithString:path]]) {
                    [app openURL:[NSURL URLWithString:path]];
                }
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            if(![self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType]){
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }
        else if([[UIApplication sharedApplication] canOpenURL:URL]) {
            [self launchExternalAppWithURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    if(self.controller)
        [self.controller presentViewController:alertController animated:YES completion:^{}];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    if(self.controller)
        [self.controller presentViewController:alertController animated:YES completion:^{}];
    
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    //back delegate
    return [self.delegate GZCwebView:self shouldStartLoadWithURL:request.URL];
}


#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if(self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    
    if(self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

#pragma mark - External App Support
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    
    //若需要限制只允许某些前缀的scheme通过请求，则取消下述注释，并在数组内添加自己需要放行的前缀
    //    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https",@"file"]];
    //    return ![validSchemes containsObject:URL.scheme];
    
    return !URL;
}

- (void)launchExternalAppWithURL:(NSURL *)URL {
    self.URLToLaunchWithPermission = URL;
    if (![self.externalAppPermissionAlertView isVisible]) {
        [self.externalAppPermissionAlertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView == self.externalAppPermissionAlertView) {
        if(buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:self.URLToLaunchWithPermission];
        }
        self.URLToLaunchWithPermission = nil;
    }
}

#pragma mark - Dealloc

- (void)dealloc {
    [self.uiWebView setDelegate:nil];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    
}

@end
