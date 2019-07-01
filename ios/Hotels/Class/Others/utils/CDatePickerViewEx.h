//
//  CDatePickerViewEx.h
//  Textfield输入
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDatePickerViewEx : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong, readonly) NSDate *date;
-(void)selectToday;

@property (nonatomic, strong) NSString *year;

@end
