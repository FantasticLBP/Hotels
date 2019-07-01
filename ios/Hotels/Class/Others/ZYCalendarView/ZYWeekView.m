//
//  ZYWeekView.m
//  Example
//
//  Created by Daniel on 16/10/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYWeekView.h"
#import "ZYDayView.h"
#import "JTDateHelper.h"

@implementation ZYWeekView {
    CGFloat dayViewWidth;
    CGFloat dayViewHeight;
    CGFloat gap;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        gap = 5;
        dayViewWidth = frame.size.width/7;
        dayViewHeight = (frame.size.width-gap*8)/7;
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDate *firstDate = [_manager.helper firstWeekDayOfWeek:_date];
    
    for (int i = 0; i < 7; i++) {
        ZYDayView *dayView = [[ZYDayView alloc] initWithFrame:CGRectMake(dayViewWidth * i, 0, dayViewWidth, dayViewHeight)];
        dayView.manager = self.manager;
        
        NSDate *dayDate = [_manager.helper addToDate:firstDate days:i];
        
        BOOL isSameMonth = [_manager.helper date:dayDate isTheSameMonthThan:_theMonthFirstDay];
        if (!isSameMonth) {
            
            if ([_manager.helper date:dayDate isAfter:[_manager.helper lastDayOfMonth:_theMonthFirstDay]]) {
                dayDate = [_manager.helper lastDayOfMonth:_theMonthFirstDay];
            } else if ([_manager.helper date:dayDate isBefore:_theMonthFirstDay]) {
                dayDate = _theMonthFirstDay;
            }
        }
        dayView.enabled = isSameMonth;
        
        dayView.date = dayDate;
        
        
        [self addSubview:dayView];
    }
}

@end
