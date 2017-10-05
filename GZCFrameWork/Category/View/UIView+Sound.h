//
//  UIView+Sound.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2016/12/21.
//  Copyright © 2016年 ZhongCheng Guo. All rights reserved.
//

//  播放音频

#import <UIKit/UIKit.h>

@interface UIView(Sound)

/**
 播放音效，只支持.caf, .aif, 或者 .wav 的文件

 @param soundName 文件名
 @param type 扩展名
 */
-(void)soundResourceNamed:(NSString *)soundName ofType:(NSString *)type;

/**
 播放音效，只支持.caf, .aif, 或者 .wav 的文件

 @param path 文件完整路径
 */
- (void)soundResourcePath:(NSURL *)path;

@end
