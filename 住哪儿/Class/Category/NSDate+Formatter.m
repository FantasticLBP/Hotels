
//
//  NSDate+Formatter.m
//  住哪儿
//
//  Created by geek on 2016/12/19.
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

-(NSInteger)calcDaysFromBegin:(NSDate *)beiginDate end:(NSDate *)endDate{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //取2个日期的时间间隔
    NSTimeInterval time = [endDate timeIntervalSinceDate:beiginDate];
    
    NSInteger days = ((NSInteger)(time))/(3600*24);
    return days;
}

@end
