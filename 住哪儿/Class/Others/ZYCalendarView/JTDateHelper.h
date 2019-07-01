//
//  JTDateHelper.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@interface JTDateHelper : NSObject

- (NSCalendar *)calendar;
- (NSDateFormatter *)createDateFormatter;

// 在某日期上加几月/天/日
- (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months;
- (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks;
- (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days;

// Must be less or equal to 6
- (NSUInteger)numberOfWeeks:(NSDate *)date;

// 第一天
- (NSDate *)firstDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfWeek:(NSDate *)date;

- (NSDate *)lastDayOfMonth:(NSDate *)date;

// 判断是否是同一个月/周/天
- (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;

// 判断是否在某个日期之前/之后
- (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB;

// 判断是否在某个日期之前/之后
- (BOOL)date:(NSDate *)dateA isBefore:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isAfter:(NSDate *)dateB;

// 判断是否在某个时间段之内
- (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate;
- (BOOL)date:(NSDate *)date isAfter:(NSDate *)startDate andBefore:(NSDate *)endDate;

@end
