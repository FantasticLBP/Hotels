//
//  ZYDayView.h
//  Example
//
//  Created by Daniel on 16/10/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCalendarManager.h"

@interface ZYDayView : UIButton
@property (nonatomic, strong)NSDate *date;
@property (nonatomic, weak)ZYCalendarManager *manager;
@end
