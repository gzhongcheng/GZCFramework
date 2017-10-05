//
//  GZCBaseModel.h
//  GZCFrameWork
//
//  Created by GuoZhongCheng on 16/5/4.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//
//  model的模版类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProjectMacros.h"
#import "GZCNetwork.h"

@interface GZCBaseModel : NSObject

@property (nonatomic, copy) NSString *identifier;


/**
 获取本地json文件的内容并解析成字典

 @param fileName 文件名称（只支持.json格式）
 @return  解析后的内容
 */
+(NSDictionary *)getDictionaryFromJsonFileNamed:(NSString *)fileName;

/**
 子类中重写，将字典中的值转成类中的属性

 @param dic 数据字典
 @return model对象
 */
+(instancetype)modelWithDic:(NSDictionary *)dic;


/**
 将json串转化成字典

 @param responseObject json串数据
 @param error NSError对象
 @return 转换后的字典/数组
 */
+(id)dicWithJsonData:(NSData *)responseObject
               error:(NSError **)error;


/**
 取消所有正在进行的请求
 */
+(void)cancelHTTPRequest;

@end
