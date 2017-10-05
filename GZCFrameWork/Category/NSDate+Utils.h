//
//  NSDate+Utils.h
//  GZCFrameWork
//
//  Created by PeterPan on 13-12-27.
//  Copyright (c) 2013年 shake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (Utils)


/**
 根据年月日事件生成日期

 @param year 年
 @param month 月
 @param day 日
 @param hour 时
 @param minute 分
 @param second 秒
 @return 日期数据
 */
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;


/**
 计算日期间间隔的天数

 @param startDate 开始时间
 @param endDate 结束时间
 @return 间隔天数
 */
+ (NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate;


/**
 获取当天指定 时 分 的日期

 @param hour 时
 @param minute 分
 @return 日期数据
 */
+ (NSDate *)dateWithHour:(int)hour
                  minute:(int)minute;

#pragma mark - Getter

/**
 获取当前年份

 @return 年份
 */
- (NSInteger)year;

/**
 获取当前月份

 @return 月份
 */
- (NSInteger)month;

/**
 获取当前日期

 @return 日期
 */
- (NSInteger)day;

/**
 获取当前小时数

 @return 小时数
 */
- (NSInteger)hour;

/**
 获取当前的分钟数

 @return 分钟数
 */
- (NSInteger)minute;

/**
 获取当前的秒数

 @return 秒数
 */
- (NSInteger)second;

/**
 获取当天的星期

 @return 星期数（如：@"星期一"）
 */
- (NSString *)weekday;


#pragma mark - Time string

/**
 获取当前时间 (格式为 00:00)

 @return 时间字符串
 */
- (NSString *)timeHourMinute;

/**
 获取当前时间 (格式为 上午 00:00)
 
 @return 时间字符串
 */
- (NSString *)timeHourMinuteWithPrefix;

/**
 获取当前时间 (格式为 00:00 am)
 
 @return 时间字符串
 */
- (NSString *)timeHourMinuteWithSuffix;

/**
 获取当前时间

 @param enablePrefix 是否显示 上午/下午
 @param enableSuffix 是否显示 am/pm
 @return 时间字符串 (格式为 上午 00:00 am , 由传入参数决定)
 */
- (NSString *)timeHourMinuteWithPrefix:(BOOL)enablePrefix
                                suffix:(BOOL)enableSuffix;

#pragma mark - Date String

//- (NSString *)stringTime;

/**
 获取当前日期
 
 @return 日期字符串 （格式为 月.日)
 */
- (NSString *)stringMonthDay;

/**
 获取当前日期

 @return 日期字符串 （格式为 yyyy-MM-dd)
 */
- (NSString *)stringYearMonthDay;

/**
 获取当前日期

 @return 日期字符串 （格式为 yyyy-MM-dd HH:mm:ss)
 */
- (NSString *)stringYearMonthDayHourMinuteSecond;

/**
 日期转换成字符串

 @param date 日期，为nil时默认当前日期
 @return 日期字符串 （格式为 yyyy-MM-dd)
 */
+ (NSString *)stringYearMonthDayWithDate:(NSDate *)date;

/**
 获取当前日期

 @return 日期字符串 （格式为 yyyy-MM-dd HH:mm:ss)
 */
+ (NSString *)stringLoacalDate;

/**
 将时间戳转换为日期字符串

 @param timeinterval 时间戳
 @param format 返回格式
 @return 的日期字符串
 */
+ (NSString *)stringWithTimeInterval:(NSString *)timeinterval
                          withFormat:(NSString *)format;


#pragma mark - Date formate
/**
 当前日期格式化

 @return 日期字符串 （格式为 yyyy-MM-dd)
 */
+ (NSString *)dateFormatString;

/**
 当前时间格式化

 @return 时间字符串 （格式为 HH:mm:ss)
 */
+ (NSString *)timeFormatString;

/**
 当前时间格式化

 @return 日期字符串 （格式为 yyyy-MM-dd HH:mm:ss)
 */
+ (NSString *)timestampFormatString;

/**
 当前时间格式化

 @return 日期字符串 （格式为 yyyy-MM-dd HH:mm)
 */
+ (NSString *)timestampFormatStringSubSeconds;

#pragma mark - Date adjust

/**
 计算指定天数后的日期

 @param dDays 天数
 @return 日期数据
 */
- (NSDate *) dateByAddingDays: (NSInteger) dDays;

/**
 计算指定天数前的日期

 @param dDays 天数
 @return 日期数据
 */
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;

#pragma mark - Relative dates from the date

/**
 获取明天的日期

 @return 日期数据
 */
+ (NSDate *) dateTomorrow;

/**
 获取昨天的日期

 @return 日期数据
 */
+ (NSDate *) dateYesterday;

/**
 获取指定天数后的日期

 @param days 天数
 @return 日期数据
 */
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;

/**
 获取指定天数前的日期

 @param days 天数
 @return 日期数据
 */
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;

/**
 获取指定小时后的日期

 @param dHours 小时数
 @return 日期数据
 */
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;

/**
 获取指定小时前的日期

 @param dHours 小时数
 @return 日期数据
 */
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;

/**
 获取指定分钟后的日期

 @param dMinutes 分钟数
 @return 日期数据
 */
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;

/**
 获取指定分钟前的数据

 @param dMinutes 分钟数
 @return 日期数据
 */
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

/**
 获取传入日期零点的日期

 @param aDate 需要计算的日期数据
 @return 零点的日期数据
 */
+ (NSDate *) dateStandardFormatTimeZeroWithDate: (NSDate *) aDate;

/**
 将self与当前时间比较

 @return 相差天数（负数为过去，正数为未来）
 */
- (NSInteger) daysFromNow;

/**
 将self与当前时间比较

 @return 相差的秒数
 */
- (NSInteger) secondsFromNow;

#pragma mark - Date compare

/**
 判断是否同一天

 @param aDate 目标日期
 @return 是否同一天，YES表示是同一天
 */
- (BOOL)isEqualToDateIgnoringTime: (NSDate *) aDate;

/**
 日期格式化

 @return “今天”，“明天”，“昨天”，或年月日
 */
- (NSString *)stringYearMonthDayCompareToday;

#pragma mark - Date and string convert

/**
 时间戳转化为时间数据

 @param timeinterval 时间戳字符串
 @return 时间数据
 */
+ (NSDate *)dateFromTimeInterval:(NSString *)timeinterval;

/**
 时间字符串转化为NSDate

 @param string 时间字符串 格式必须为 yyyy-MM-dd HH:mm:ss
 @return NSDate数据
 */
+ (NSDate *)dateFromString:(NSString *)string;

/**
 时间字符串转化为NSDate

 @param string 时间字符串
 @param format 字符串格式，如 yyyy-MM-dd HH:mm:ss
 @return NSDate数据
 */
+ (NSDate *)dateFromString:(NSString *)string
                withFormat:(NSString *)format;

/**
 NSDate转化为时间字符串

 @return 时间字符串 格式为 yyyy-MM-dd HH:mm:ss
 */
- (NSString *)string;

/**
 NSDate转化为时间字符串
 
 @return 时间字符串 格式为 yyyy-MM-dd HH:mm
 */
- (NSString *)stringCutSeconds;

#pragma mark - TimeInterval

/**
 获取当前时间戳

 @return 时间戳字符串
 */
+ (NSString *)timeInterval;

@end
