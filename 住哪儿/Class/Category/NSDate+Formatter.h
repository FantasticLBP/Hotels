//
//  NSDate+Formatter.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/19.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

/**
 * 单例该对象
 */
+(NSDate *)sharedInstance;

/**
 * 格式化输出
 * eg:12月8号今天
 */
-(NSString *)today;

/**
 * 获得当前日期的明天
 */
-(NSString *)GetTomorrowDay;

/**
 * 2个日期的相差天数
 *
 */
-(NSInteger)calcDaysFromBegin:(NSString *)beiginDate end:(NSString *)endDate;

/**
 * 格式化输出
 * eg:12月8号今天
 */
-(NSString *)todayString;

/**
 * 获得当前日期的明天
 */
-(NSString *)GetTomorrowDayString;


@end
