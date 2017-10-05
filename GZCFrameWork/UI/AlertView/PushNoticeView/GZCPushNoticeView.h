//
//  GZCPushNoticeView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

//  收到推送／通知时弹出窗口

#import <UIKit/UIKit.h>

@interface GZCPushNoticeView : UIView

/**
 标题（长度不超过12个汉字）
 */
@property (nonatomic,  copy) NSString *title;

/**
 内容
 */
@property (nonatomic,  copy) NSString *content;

/**
 网络图片地址（或者本地图片名称）
 */
@property (nonatomic,  copy) NSString *imageURL;

/**
 确定按钮文字(长度最好不超过12个汉字)
 */
@property (nonatomic,  copy) NSString *doneTitle;

/**
 点击确定按钮的回调
 */
@property (nonatomic , copy ) void (^doneBlock)();

/**
 点击关闭按钮的回调
 */
@property (nonatomic , copy ) void (^closeBlock)();

@end
