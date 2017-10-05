//
//  GZCBaseModel.h
//  JiuMei
//
//  Created by GuoZhongCheng on 16/5/4.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GZCFramework.h"

@interface GZCBaseModel : NSObject

@property (nonatomic, copy) NSString *identifier;

//重写
+(instancetype)modelWithDic:(NSDictionary *)dic;

+(id)dicWithJsonData:(NSData *)responseObject
                           error:(NSError **)error;

@end
