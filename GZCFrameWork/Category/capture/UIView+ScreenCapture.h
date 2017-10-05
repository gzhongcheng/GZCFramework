//
//  UIView+ScreenCapture.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/7/14.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

//  View截图

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UIView(ScreenCapture)

@property (nonatomic,assign) BOOL capturing;


/**
 获取截图

 @return 截图
 */
- (UIImage *)capture;


/**
 ScrollView截图

 @param scrollView 目标Scrollview
 @return 截图
 */
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;


@end
