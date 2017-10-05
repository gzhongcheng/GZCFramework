//
//  StringAttributeHandle.h
//  GZCFrameWork
//
//  Created by ZhongCheng Guo on 2017/7/10.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringAttributeHandle : NSObject

/**
 属性名字
 */
@property (nonatomic,  copy) NSString *attributeName;

/**
 属性对应的值
 */
@property (nonatomic,strong) id attributeValue;

/**
 *  属性设置生效范围
 */
@property (nonatomic ,assign) NSRange  effectRange;

@end

@interface FontAttribute : StringAttributeHandle

/**
 * 字体
 */
@property (nonatomic, strong) UIFont *font;

@end

@interface ColorAttribute : StringAttributeHandle

/**
 * 颜色
 */
@property (nonatomic, strong) UIColor *color;

@end
