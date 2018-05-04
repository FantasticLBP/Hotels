//
//  ZYCalendarManager.m
//  Example
//
//  Created by Daniel on 2016/10/30.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYCalendarManager.h"

@implementation ZYCalendarManager

-(JTDateHelper *)helper {
    if (!_helper) {
        _helper = [JTDateHelper new];
    }
    return _helper;
}

- (NSMutableArray *)selectedDateArray {
    if (!_selectedDateArray) {
        _selectedDateArray = @[].mutableCopy;
    }
    return _selectedDateArray;
}

- (NSDateFormatter *)titleDateFormatter {
    if (!_titleDateFormatter) {
        _titleDateFormatter = [self.helper createDateFormatter];
        _titleDateFormatter.dateFormat = @"yyyy年MM月";
    }
    return _titleDateFormatter;
}

- (NSDateFormatter *)dayDateFormatter {
    if (!_dayDateFormatter) {
        _dayDateFormatter = [self.helper createDateFormatter];
        _dayDateFormatter.dateFormat = @"dd";
    }
    return _dayDateFormatter;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [self.helper createDateFormatter];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

@end
