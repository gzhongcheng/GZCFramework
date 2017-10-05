//
//  UIView+StringTag.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/1/4.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

//  给View添加String类型的标记

#import <UIKit/UIKit.h>

@interface UIView (StringTag)

@property (nonatomic, strong) NSString *stringTag;


/**
 根据StringTag获取View

 @param tag StringTag
 @return 获取的的View
 */
- (UIView *)viewWithStringTag:(NSString *)tag;

/**
 获取当前的焦点View

 @return 获取焦点的View
 */
- (UIView *)findFirstResponder;

@end
