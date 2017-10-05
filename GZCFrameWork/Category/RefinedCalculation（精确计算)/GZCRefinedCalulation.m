//
//  GZCRefinedCalulation.m
//  JoYsDo
//
//  Created by ZhongCheng Guo on 2017/8/28.
//  Copyright © 2017年 ZhongCheng Guo. All rights reserved.
//

#import "GZCRefinedCalulation.h"

@implementation NSObject (RefinedCalulation)

+(NSString *)add:(NSString *)a and:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByAdding:bNumber];
    return [product stringValue];
}
+(float)addFloat:(float)a and:(float)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",b]];
    NSDecimalNumber *product = [aNumber decimalNumberByAdding:bNumber];
    return [product floatValue];
}

+(NSString *)subtract:(NSString *)a and:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberBySubtracting:bNumber];
    return [product stringValue];
}
+(float)subtractFloat:(float)a and:(float)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",b]];
    NSDecimalNumber *product = [aNumber decimalNumberBySubtracting:bNumber];
    return [product floatValue];
}

+(NSString *)multiply:(NSString *)a and:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingBy:bNumber];
    return [product stringValue];
}
+(float)multiplyFloat:(float)a and:(float)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",b]];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingBy:bNumber];
    return [product floatValue];
}

+(NSString *)divide:(NSString *)a and:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByDividingBy:bNumber];
    return [product stringValue];
}
+(float)divideFloat:(float)a and:(float)b{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",b]];
    NSDecimalNumber *product = [aNumber decimalNumberByDividingBy:bNumber withBehavior:roundUp];
    return [product floatValue];
}

+(NSString *)raisingToPower:(NSString *)a and:(NSUInteger)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *product = [aNumber decimalNumberByRaisingToPower:b];
    return [product stringValue];
}
+(float)raisingToPowerFloat:(float)a and:(NSUInteger)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *product = [aNumber decimalNumberByRaisingToPower:b];
    return [product floatValue];
}

+(NSString *)multiplyingByPowerOf10:(NSString *)a and:(short)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingByPowerOf10:b];
    return [product stringValue];
}
+(float)multiplyingByPowerOf10Float:(float)a and:(short)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",a]];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingByPowerOf10:b];
    return [product floatValue];
}

@end

@implementation NSString(RefinedCalulation)

-(NSString *)add:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByAdding:bNumber];
    return [product stringValue];
}

-(NSString *)subtract:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberBySubtracting:bNumber];
    return [product stringValue];
}

-(NSString *)multiply:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingBy:bNumber];
    return [product stringValue];
}

-(NSString *)divide:(NSString *)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *product = [aNumber decimalNumberByDividingBy:bNumber];
    return [product stringValue];
}

-(NSString *)raisingToPower:(NSUInteger)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *product = [aNumber decimalNumberByRaisingToPower:b];
    return [product stringValue];
}

-(NSString *)multiplyingByPowerOf10:(short)b{
    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *product = [aNumber decimalNumberByMultiplyingByPowerOf10:b];
    return [product stringValue];
}

@end
