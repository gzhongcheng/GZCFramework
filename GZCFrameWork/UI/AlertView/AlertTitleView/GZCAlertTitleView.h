//
//  GZCAlertTitleView.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZCAlertHandle.h"

@interface GZCAlertTitleView : UIView

/**
 标题
 */
@property (nonatomic,strong) GZCAlertItem *title;

/**
 提示内容
 */
@property (nonatomic,strong) GZCAlertItem *message;

@end
