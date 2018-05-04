//
//  DateUtils.h
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectUtil.h"

@interface DateUtils : NSObject
{
    NSDateFormatter *dateFormatter;
}

+ (NSString *)formateDate:(NSDate *)date;

+ (NSString *)formateDate2:(NSDate *)date;

+ (NSString *)formateDate3:(NSDate *)date;

+ (NSString *)formateDate4:(NSDate *)date;

+ (NSString *)formateDateTime:(NSDate *)date;

+ (NSString *)formateLongDateTime:(NSDate *)date;

+ (NSString *)formateShortChineseDate:(NSDate *)date;

+ (NSString *)formateLongChineseDate:(NSDate *)date;

+ (NSString *)formateLongChineseTime:(long long)time;

+ (NSString *)formateChineseDate:(NSDate *)date;

+ (NSString *)formateChineseDate2:(NSDate *)date;

+ (NSString *)formateChineseTime:(NSDate *)date;

+ (NSString *)formateTime:(long long)time;

+ (NSString *)formateTime2:(long long)time;

+ (NSString *)formateTime3:(long long)time;

+ (NSString *)formateChineseTime3:(long long)time;

+ (NSString *)formateShortTime2:(long long)time;

+ (NSString *)formateShortTime:(NSInteger)time;

+ (NSString *)formateChineseTime2:(long long)time;

+ (NSString *)formateChineseShortDate:(long long)time;

+ (NSString *)formateChineseShortDate2:(NSDate *)date;

+ (NSInteger)getMinuteOfDate:(NSDate *)date;

+ (NSDate *)parseDateTime:(NSString *)datetime;

+ (NSDate *)parseDateTime2:(NSString *)datetime;

+ (NSDate *)parseDateTime3:(NSString *)datetime;

+ (NSDate *)parseDateTime4:(NSString *)datetime;

+ (NSDate *)parseDateTime5:(NSString *)datetime;

+ (NSDate *)parseDateTime6:(NSString *)datetime;

+ (NSDate *)parseTodayTime:(NSInteger)time;

+ (NSDate *)getTodayLastTime;

+ (NSDate *)getTimeSinceNow:(NSTimeInterval)interval;

+ (NSString *)getWeeKName:(NSInteger)week;

//供应链添加转换日期格式
+ (long long)formateDateTime2:(NSString*)datetime;
//供应链添加转换日期格式
+ (long long)formateDateTime3:(NSString*)datetime;

//获取本月的第一天
+ (NSDate *)getFirstDayOfThisMont;
//获得本周的第一天
+ (NSDate *)getThisWeekFirstDay;

// 今天 昨天 最近三天 本周 本月 自定义时间 转为字符串
+ (long long)converStartTime:(NSString *)time;
+ (long long)converEndTime:(NSString *)time;

//获取本月的第一天和最后一天
+(NSArray *)getFirstAndLastDayOfThisMonth;

//获取本周的第一天和最后一天
+(NSArray *)getFirstAndLastDayOfThisWeek;
@end
