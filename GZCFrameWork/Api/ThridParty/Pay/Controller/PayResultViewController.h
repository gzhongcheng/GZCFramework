//
//  MSPayResultViewController.h
//  MemberSystem
//
//  Created by GuoZhongCheng on 16/7/28.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCNormalTitleViewController.h"

typedef enum : NSUInteger {
    PayResultSuccess//,
//    PayResultWating,
//    PayResultFailed
} PayResultState;

@interface PayResultViewController : GZCNormalTitleViewController

@property (nonatomic, assign) PayResultState resultState;      //支付结果,默认为支付成功,暂时只有支付成功才显示这个界面

@end
