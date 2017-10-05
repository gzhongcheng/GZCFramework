//
//  GZCRefinedCalulation.h
//  JoYsDo
//
//  Created by ZhongCheng Guo on 2017/8/28.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (RefinedCalulation)

/**
 @param a 数字字符串a / 数字a
 @param b 数字字符串b / 数字b
 @return 结果
 */
/**
 a+b
 */
+(NSString *)add:(NSString *)a
             and:(NSString *)b;
+(float)addFloat:(float)a
             and:(float)b;

/**
 a-b
 */
+(NSString *)subtract:(NSString *)a
                  and:(NSString *)b;
+(float)subtractFloat:(float)a
                  and:(float)b;

/**
 a*b
 */
+(NSString *)multiply:(NSString *)a
                  and:(NSString *)b;
+(float)multiplyFloat:(float)a
                  and:(float)b;

/**
 a/b
 */
+(NSString *)divide:(NSString *)a
                and:(NSString *)b;
+(float)divideFloat:(float)a
                and:(float)b;

/**
 a^b
 */
+(NSString *)raisingToPower:(NSString *)a
                        and:(NSUInteger)b;
+(float)raisingToPowerFloat:(float)a
                        and:(NSUInteger)b;

/**
 a*10^(-b)
 */
+(NSString *)multiplyingByPowerOf10:(NSString *)a
                                and:(short)b;
+(float)multiplyingByPowerOf10Float:(float)a
                                and:(short)b;

@end

@interface NSString(RefinedCalulation)

/**
 @param b 数字字符串B
 @return 结果
 */
/**
 self+b
 */
-(NSString *)add:(NSString *)b;

/**
 self-b
 */
-(NSString *)subtract:(NSString *)b;

/**
 self*b
 */
-(NSString *)multiply:(NSString *)b;

/**
 self/b
 */
-(NSString *)divide:(NSString *)b;

/**
 self^b
 */
-(NSString *)raisingToPower:(NSUInteger)b;

/**
 self*10^(-b)
 */
-(NSString *)multiplyingByPowerOf10:(short)b;

@end
