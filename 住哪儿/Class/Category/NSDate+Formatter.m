
//
//  NSDate+Formatter.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/19.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

+(NSDate *)sharedInstance{
    static NSDate *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NSDate date];
    });
    return instance;
}

-(NSString *)today{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日";
    NSString *today = [formatter stringFromDate:date];
    return today;
}

-(NSString *)GetTomorrowDay{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM月dd日"];
    return [dateday stringFromDate:beginningOfWeek];
}

-(NSInteger)calcDaysFromBegin:(NSString *)beiginDate end:(NSString *)endDate{
    //开始时间
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSDate *startDay;
    NSDate *endDay;
    
    if (beiginDate.length >6) {
        currentDateStr = [currentDateStr stringByReplacingOccurrencesOfString:[currentDateStr substringWithRange:NSMakeRange(5, 5)] withString:[beiginDate substringWithRange:NSMakeRange(5, 5)]];
        startDay = [dateFormat dateFromString:[currentDateStr stringByReplacingOccurrencesOfString:@" +0000" withString:@""]];
        
    }else{
        currentDateStr = [currentDateStr stringByReplacingOccurrencesOfString:[currentDateStr substringWithRange:NSMakeRange(5, 5)] withString:[
                                                                                                                                                NSString stringWithFormat:@"%@-%@",[beiginDate substringToIndex:2],[beiginDate substringWithRange:NSMakeRange(3, 2)]]];
        startDay = [dateFormat dateFromString:currentDateStr];
        
    }
    
    
    //结束时间
    if (endDate.length == 5) {
        NSString *endDateStr = [currentDateStr stringByReplacingOccurrencesOfString:[currentDateStr substringWithRange:NSMakeRange(5, 5)] withString:[ProjectUtil isNotBlank:endDate]?endDate:[NSString stringWithFormat:@"%@-%@",[beiginDate substringWithRange:NSMakeRange(0, 2)],[beiginDate substringWithRange:NSMakeRange(3, 2)]]];
        endDay = [dateFormat dateFromString:endDateStr];
    }else{
        endDay = [dateFormat dateFromString:endDate];
    }
    
    //取2个日期的时间间隔
    NSTimeInterval time = [endDay timeIntervalSinceDate:startDay];
    NSInteger days = ((NSInteger)(time))/(3600*24);
    return days+1;
}

-(NSString *)todayString{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *today = [formatter stringFromDate:date];
    return today;
}

-(NSString *)GetTomorrowDayString{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

@end
