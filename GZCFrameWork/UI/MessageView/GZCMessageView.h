//
//  GZCMessageView.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/6/23.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZCMessageView : UILabel

+(instancetype)shareInstance;

+(void)showMessage:(NSString*)message;

+(void)showMessage:(NSString *)message
            inView:(UIView *)view
       displayTime:(float)display;

@end
