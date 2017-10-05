//
//  NSDictory+AppendSignString.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/7/30.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//
//  字典拼接 (支付接口用的)

#import <Foundation/Foundation.h>

@interface NSDictionary(AppendSignString)


/**
 将字典按照key=value拼接字符串，并以&分割

 @return 拼接后的字符串
 */
-(NSString *)appendSignedString;

@end
