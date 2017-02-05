//
//  ZYCalendarView.m
//  Example
//
//  Created by Daniel on 16/10/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYCalendarView.h"
#import "ZYMonthView.h"
#import "JTDateHelper.h"

@implementation ZYCalendarView {
    CGSize lastSize;
    
    ZYMonthView *monthView1;
    ZYMonthView *monthView2;
    ZYMonthView *monthView3;
    ZYMonthView *monthView4;
    ZYMonthView *monthView5;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)layoutSubviews {
    // 修改大小
    [self resizeViewsIfWidthChanged];
    // 滚动
    [self viewDidScroll];
}

- (void)setDayViewBlock:(void (^)(id))dayViewBlock {
    _dayViewBlock = dayViewBlock;
    self.manager.dayViewBlock = _dayViewBlock;
}

- (ZYCalendarManager *)manager {
    if (!_manager) {
        _manager = [ZYCalendarManager new];
    }
    return _manager;
}

- (void)resizeViewsIfWidthChanged
{
    CGSize size = self.frame.size;
    
    // 首次加载
    if (!lastSize.width) {
        [self repositionViews];
    }
    
    // self的宽改变
    if(size.width != lastSize.width){
        lastSize = size;
        
        monthView1.frame = CGRectMake(0, monthView1.frame.origin.y, size.width, monthView1.frame.size.height);
        monthView2.frame = CGRectMake(0, monthView2.frame.origin.y, size.width, monthView2.frame.size.height);
        monthView3.frame = CGRectMake(0, monthView3.frame.origin.y, size.width, monthView3.frame.size.height);
        monthView4.frame = CGRectMake(0, monthView4.frame.origin.y, size.width, monthView4.frame.size.height);
        monthView5.frame = CGRectMake(0, monthView5.frame.origin.y, size.width, monthView5.frame.size.height);
        
        self.contentSize = CGSizeMake(size.width, self.contentSize.height);
    }
}

// 首次加载
- (void)repositionViews {
    CGSize size = self.frame.size;
    
    if (!monthView1) {
        monthView1 = [[ZYMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        monthView2 = [[ZYMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        monthView3 = [[ZYMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        monthView4 = [[ZYMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        monthView5 = [[ZYMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        
        monthView1.tag = 1;
        monthView1.tag = 2;
        monthView1.tag = 3;
        monthView1.tag = 4;
        monthView1.tag = 5;
        
        monthView1.manager = self.manager;
        monthView2.manager = self.manager;
        monthView3.manager = self.manager;
        monthView4.manager = self.manager;
        monthView5.manager = self.manager;
        
        [self addSubview:monthView1];
        [self addSubview:monthView2];
        [self addSubview:monthView3];
        [self addSubview:monthView4];
        [self addSubview:monthView5];
        
        self.date = _date;
    }
    
    self.contentSize = CGSizeMake(size.width, monthView1.frame.size.height + monthView2.frame.size.height + monthView3.frame.size.height + monthView4.frame.size.height + monthView5.frame.size.height);
    self.contentOffset = CGPointMake(0, monthView1.frame.size.height + monthView2.frame.size.height);
    
    [self resetMonthViewsFrame];
    
}

// 滚动了
- (void)viewDidScroll {
    if(self.contentSize.height <= 0){
        return;
    }
    
    if(self.contentOffset.y < monthView1.frame.size.height + monthView2.frame.size.height/2.0){
        // 加载上一页(如果是当前日期的上一个月, 不加载)
        [self loadPreviousPage];
    }
    else if(self.contentOffset.y > monthView1.frame.size.height+monthView2.frame.size.height+monthView3.frame.size.height/2.0){
        // 加载下一页
        [self loadNextPage];
    }
}

- (void)loadPreviousPage {
    
    ZYMonthView *tmpView = monthView5;
    
    monthView5 = monthView4;
    monthView4 = monthView3;
    monthView3 = monthView2;
    monthView2 = monthView1;
    
    monthView1 = tmpView;
    
    monthView1.date = [self.manager.helper addToDate:monthView2.date months:-1];
    
    [self resetMonthViewsFrame];
    
    self.contentOffset = CGPointMake(0, self.contentOffset.y + monthView1.frame.size.height);
}

- (void)loadNextPage {
    
    CGFloat height1 = monthView1.frame.size.height;
    
    ZYMonthView *tmpView = monthView1;
    
    monthView1 = monthView2;
    monthView2 = monthView3;
    monthView3 = monthView4;
    monthView4 = monthView5;
    
    monthView5 = tmpView;
    monthView5.date = [self.manager.helper addToDate:monthView4.date months:1];
    
    [self resetMonthViewsFrame];
    
    self.contentOffset = CGPointMake(0, self.contentOffset.y - height1);
}

- (void)resetMonthViewsFrame {
    CGSize size = self.frame.size;
    monthView1.frame = CGRectMake(0, 0, size.width, monthView1.frame.size.height);
    monthView2.frame = CGRectMake(0, CGRectGetMaxY(monthView1.frame), size.width, monthView2.frame.size.height);
    monthView3.frame = CGRectMake(0, CGRectGetMaxY(monthView2.frame), size.width, monthView3.frame.size.height);
    monthView4.frame = CGRectMake(0, CGRectGetMaxY(monthView3.frame), size.width, monthView4.frame.size.height);
    monthView5.frame = CGRectMake(0, CGRectGetMaxY(monthView4.frame), size.width, monthView5.frame.size.height);
    self.contentSize = CGSizeMake(size.width,
                                  monthView1.frame.size.height + monthView2.frame.size.height + monthView3.frame.size.height + monthView4.frame.size.height + monthView5.frame.size.height);
}

- (void)setDate:(NSDate *)date {
    _date = date;
    _manager.date = date;
    
    monthView1.date = [self.manager.helper addToDate:date months:-2];
    monthView2.date = [self.manager.helper addToDate:date months:-1];
    monthView3.date = date;
    monthView4.date = [self.manager.helper addToDate:date months:1];
    monthView5.date = [self.manager.helper addToDate:date months:2];
}



@end
