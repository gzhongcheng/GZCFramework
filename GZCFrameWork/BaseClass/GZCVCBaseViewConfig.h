//
//  GZCVCBaseViewConfig.h
//  wokanapp
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//
//  GZCBaseViewController的中各个默认容器的基本配置

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GZCVCBaseViewConfig : NSObject

/**
 view的背景色
 */
@property (nonatomic) UIColor  *backgroundColor;

/**
 是否存在（是否显示）
 */
@property (nonatomic) BOOL      exist;

/**
 view的frame
 */
@property (nonatomic) CGRect    frame;

@end
