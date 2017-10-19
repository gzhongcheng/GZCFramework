//
//  UtilsMacros.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

//  通用宏定义

#ifndef define_h
#define define_h

/**
 获取系统对象
 **/
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取UUID
#define kDiviceKey          [[[UIDevice currentDevice]identifierForVendor] UUIDString]
#define LocalString(key)    NSLocalizedStringFromTable(key,@"Localizable", nil)

/**
 屏幕相关
 **/
#define KScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight       [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds      [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth   KScreenWidth/375.0
#define Iphone6ScaleHeight  KScreenHeight/667.0

#define Iphone_X_Device     KScreenHeight>810.0f
//根据ip6的屏幕来拉伸
#define kRealValue(with)    ((with)*(KScreenWidth/375.0f))

/**
 强弱引用
 **/
#define kWeakSelf(type)     __weak typeof(type) weak##type = type;
#define kStrongSelf(type)   __strong typeof(type) type = weak##type;

/**
 View相关
 **/
//圆角和加边框
#define ViewBorderRadius    (View, Radius, Width, Color)\
                            \
                            [View.layer setCornerRadius:(Radius)];\
                            [View.layer setMasksToBounds:YES];\
                            [View.layer setBorderWidth:(Width)];\
                            [View.layer setBorderColor:[Color CGColor]]

//圆角
#define ViewRadius          (View, Radius)\
                            \
                            [View.layer setCornerRadius:(Radius)];\
                            [View.layer setMasksToBounds:YES]

/**
 版本相关
 **/
//版本判断
#define IOSAVAILABLEVERSION(version)    ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion            [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage                 (NSLocale preferredLanguages] objectAtIndex:0])

/**
 打印日志
 **/
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define GZCLog(fmt,...)     NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#define GZCPrint(...)       printf(__VA_ARGS__)
#else
#define GZCLog(...)
#define GZCPrint(...)
#endif

/**
 拼接字符串
 **/
#define AppendString(format,...)      [NSString stringWithFormat:format,##__VA_ARGS__]

/**
 颜色相关
 **/
#import "UIColor+Utils.h"

/**
 字体
 **/
#import "UIFont+Fonts.h"

/**
 坐标相关
 **/
#import "UIView+Rect.h"

//UIImage对象
#import "UIImage+Resize.h"
#import "UIImage+WebSize.h"
#import "UIImage+RenderedImage.h"
#define ImageWithFile(_pointer)     [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name)           [UIImage imageNamed:name]

/**
 数据验证
 **/
#define StrValid(f)         (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f)          (StrValid(f) ? f:@"")
#define HasString(str,eky)  ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f)         StrValid(f)
#define ValidDict(f)        (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f)       (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f)         (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls)   (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f)        (f!=nil && [f isKindOfClass:[NSData class]])

//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

/**
 GCD
 **/
//子线程运行
#define kDISPATCH_ASYNC_BLOCK(block)    \
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
//主线程运行
#define kDISPATCH_MAIN_BLOCK(block)     \
        dispatch_async(dispatch_get_main_queue(),block)
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//主线程运行
#define gzc_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

/**
 单例化一个类
 **/
//.h
#define SINGLETON_FOR_HEADER \
\
+ (instancetype)shareInstance;
//.m
#define SINGLETON_FOR_CLASS(className) \
\
+ (instancetype)shareInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* define_h */
