//
//  TimerPickerVC.h
//  Example
//
//  Created by 杭城小刘 on 2017/2/5.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimerPickerVC;


@protocol TimerPickerVCDelegate <NSObject>

-(void)timerPickerVC:(TimerPickerVC *)vc didPickedTime:(NSDate *)period;

@end
@interface TimerPickerVC : UIViewController
@property (nonatomic, weak) id<TimerPickerVCDelegate> delegate;
@end
