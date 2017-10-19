//
//  GZCQiandaoNoticeView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/6/13.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

//  签到成功的提示框

#import <UIKit/UIKit.h>

@interface GZCQiandaoNoticeView : UIView

/**
 奖品图片链接
 */
@property (nonatomic,  copy) NSString *prizeURL;

/**
 奖品数量
 */
@property (nonatomic,  copy) NSString *sroce;

/**
 累计签到天数
 */
@property (nonatomic,  copy) NSString *day;

/**
 奖品说明
 */
@property (nonatomic,  copy) NSString *desc;

/**
 确定按钮文字
 */
@property (nonatomic,  copy) NSString *doneTitle;

/**
 点击确定按钮的回调
 */
@property (nonatomic , copy ) void (^doneBlock)(void);

/**
 点击关闭按钮的回调
 */
@property (nonatomic , copy ) void (^closeBlock)(void);

@end
