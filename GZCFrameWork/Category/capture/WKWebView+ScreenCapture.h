//
//  WKWebView+ScreenCapture.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/12.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

//  WKWebView截图

#import <WebKit/WebKit.h>

@interface WKWebView(ScreenCapture)


/**
 WKWebView截图

 @param callback 回调函数，image为截取到的图片
 */
- (void)captureCallback:(void(^)(UIImage * image))callback;

@end
