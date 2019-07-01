
//
//  TimerPickerVC.m
//  Example
//
//  Created by 杭城小刘 on 2017/2/5.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "TimerPickerVC.h"
#import "ZYCalendarView.h"

@interface TimerPickerVC ()

@end

@implementation TimerPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *weekTitlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:weekTitlesView];
    CGFloat weekW = self.view.frame.size.width/7;
    NSArray *titles = @[@"周日", @"周一", @"周二", @"周三",
                        @"周四", @"周五", @"周六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(i*weekW, 20, weekW, 44)];
        week.textAlignment = NSTextAlignmentCenter;
        week.textColor = ZYHEXCOLOR(0x666666);
        if (i == 0 || i == 6) {
            week.textColor = [UIColor redColor];
        }
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    
    ZYCalendarView *view = [[ZYCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    // 不可以点击已经过去的日期
    view.manager.canSelectPastDays = false;
    // 可以选择时间段
    view.manager.selectionType = ZYCalendarSelectionTypeRange;
    // 设置当前日期
    view.date = [NSDate date];

    view.dayViewBlock = ^(NSDate *dayDate) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(timerPickerVC:didPickedTime:)]) {
            [self.delegate timerPickerVC:self didPickedTime:dayDate];
        }
       [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    [self.view addSubview:view];
}


@end
