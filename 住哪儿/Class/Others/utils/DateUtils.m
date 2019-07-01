//
//  DateUtils.m
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "DateUtils.h"
#import "ValidateUtil.h"
#import "NSString+Estimate.h"
#import "ObjectUtil.h"

static DateUtils *dateUtils;

@implementation DateUtils

- (id)init
{
    self = [super init];
    if (self) {
        dateFormatter = [[NSDateFormatter alloc]init];
    }
    return self;
}

+ (NSString *)formateDate:(NSDate *)date
{
    [self build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd EEEE"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateDate2:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateDate3:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateDate4:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateDateTime:(NSDate *)date
{
    [self build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateLongDateTime:(NSDate *)date
{
    [self build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss+ffff"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateShortChineseDate:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateLongChineseDate:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateLongChineseTime:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateChineseDate:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateChineseDate2:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateChineseTime:(NSDate *)date;
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"HH:mm"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSString *)formateTime:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateTime2:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateTime3:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateChineseTime3:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateChineseTime2:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateShortTime2:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"HH:mm"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateShortTime:(NSInteger)time
{
    return [NSString stringWithFormat:@"%.2li:%.2li", time/60, time%60];
}

+ (NSString *)formateChineseShortDate:(long long)time
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    return [dateUtils->dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time/1000.0]];
}

+ (NSString *)formateChineseShortDate2:(NSDate *)date
{
    if ([ObjectUtil isNotNull:date]) {
        [DateUtils build];
        [dateUtils->dateFormatter setDateFormat:@"MM月dd日"];
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return @"";
}

+ (NSInteger)getMinuteOfDate:(NSDate *)date{
    if ([ObjectUtil isNotNull:date]) {
        NSString *timeStr = [DateUtils formateChineseTime:date];
        NSArray *times = [timeStr componentsSeparatedByString:@":"];
        if (times.count==2) {
            NSString *time1 = [times objectAtIndex:0];
            NSString *time2 = [times objectAtIndex:1];
            return time1.integerValue*60 + time2.integerValue;
        }
    }
    return 0;
}

+ (NSDate *)parseDateTime:(NSString *)datetime
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateUtils->dateFormatter dateFromString:datetime];
}

+ (NSDate *)parseDateTime2:(NSString *)datetime
{
    [DateUtils build];
    if ([NSString isNotBlank:datetime]) {
        [dateUtils->dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm:ss a"];
        [dateUtils->dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        return [dateUtils->dateFormatter dateFromString:datetime];
    }
    return nil;
}

+ (NSDate *)parseDateTime3:(NSString *)datetime
{
    [DateUtils build];
    datetime=[datetime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateUtils->dateFormatter dateFromString:datetime];
}

+ (NSDate *)parseDateTime4:(NSString *)datetime
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateUtils->dateFormatter dateFromString:datetime];
}

+ (NSDate *)parseDateTime5:(NSString *)datetime
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyy"];
    return [dateUtils->dateFormatter dateFromString:datetime];
}

+ (NSDate *)parseDateTime6:(NSString *)datetime
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"HH:mm"];
    return [dateUtils->dateFormatter dateFromString:datetime];
}

+ (NSDate *)getTodayLastTime
{
    NSString *dateTime = [[DateUtils formateDate2:[NSDate date]] stringByAppendingString:@"23:59"];
    return [DateUtils parseDateTime:dateTime];
}

+ (NSDate *)parseTodayTime:(NSInteger)time
{
    NSString *timeStr = [DateUtils formateShortTime:time];
    NSString *dateStr = [DateUtils formateDate2:[NSDate date]];
    return [DateUtils parseDateTime:[dateStr stringByAppendingFormat:@" %@", timeStr]];
}

+ (NSDate *)getTimeSinceNow:(NSTimeInterval)interval
{
    return [NSDate dateWithTimeIntervalSinceNow:interval];
}

+ (NSString*) getWeeKName:(NSInteger)week
{
    if (week==1) {
        return @"星期日";
    } else if (week==2){
        return @"星期一";
    } else if (week==3){
        return @"星期二";
    } else if (week==4){
        return @"星期三";
    } else if (week==5){
        return @"星期四";
    } else if (week==6){
        return @"星期五";
    } else {
        return @"星期六";
    }
}

//供应链新增日期时间转时间戳
+ (long long)formateDateTime2:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:datetime];
    return  (long long)[date timeIntervalSince1970]*1000;
}

//供应链新增日期时间转时间戳
+ (long long)formateDateTime3:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:datetime];
    return  (long long)[date timeIntervalSince1970]*1000;
}
+ (void)build
{
    if (dateUtils == nil) {
        dateUtils = [[DateUtils alloc]init];
    }
}





//获取本月的第一天
+ (NSDate *)getFirstDayOfThisMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:[NSDate date]];
    [dateComponents setDay:1];
    NSDate *date = [calender dateFromComponents:dateComponents];
    return date;
}
//获得本周的第一天
+ (NSDate *)getThisWeekFirstDay {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:[NSDate date]];
    NSInteger weekday = dateComponents.weekday;
    NSInteger firstDay;
    if (weekday == 1) {
        firstDay = -6;
    } else {
        firstDay = -weekday + 2;
    }
    NSInteger day = dateComponents.day;
    NSDateComponents *firstComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:[NSDate date]];
    [firstComponents setDay:day + firstDay];
    NSDate *firstDate = [calender dateFromComponents:firstComponents];
    return firstDate;
    
}
// 今天 昨天 最近三天 本周 本月 自定义时间 转为字符串
+ (long long)converStartTime:(NSString *)time {
    if ([time isEqualToString:@"今天"]) {
        return [self formateDateTime3:[self formateDate2:[NSDate date]]];
    } else if ([time isEqualToString:@"昨天"]) {
        return [self formateDateTime3:[self formateDate2:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]]];
    } else if ([time isEqualToString:@"最近三天"]) {
        return [self formateDateTime3:[self formateDate2:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60*2)]]];
    } else if ([time isEqualToString:@"本周"]) {
        return [self formateDateTime3:[self formateDate2:[self getThisWeekFirstDay]]];
    } else if ([time isEqualToString:@"本月"]) {
        return [self formateDateTime3:[self formateDate2:[self getFirstDayOfThisMonth]]];
    } else {//自定义
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        return [self formateDateTime3:[self formateDate2:[formater dateFromString:time]]];
    }
}
+ (long long)converEndTime:(NSString *)time {
    if ([time isEqualToString:@"今天"]) {
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[NSDate date]]]] + 999;
    } else if ([time isEqualToString:@"昨天"]) {
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]]]] + 999;
    }else if ([time isEqualToString:@"最近三天"]) {
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[NSDate date]]]] + 999;
    } else if ([time isEqualToString:@"本周"]) {
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[NSDate date]]]] + 999;
    } else if ([time isEqualToString:@"本月"]) {
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[NSDate date]]]] + 999;
    } else {//自定义
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        return [self formateDateTime2:[NSString stringWithFormat:@"%@ 23:59:59",[self formateDate2:[formater dateFromString:time]]]] + 999;
    }
}


+(NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit |NSDayCalendarUnit fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

+(NSArray *)getFirstAndLastDayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];   //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else {
        firstDiff = 2 - weekday;
        lastDiff = 8 - weekday;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    NSDateComponents *lastComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [lastComponents setDay:day+lastDiff];
    NSDate *lastDay = [calendar dateFromComponents:lastComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}


@end
