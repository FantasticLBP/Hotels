//
//  HotelDetailVC.h
//  住哪儿
//
//  Created by geek on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelsModel.h"

@interface HotelDetailVC : UIViewController
@property (nonatomic, strong) NSString *startPeriod;            /**<入住时间*/
@property (nonatomic, strong) NSString *leavePerios;            /**<离开时间*/
@property (nonatomic, strong) HotelsModel *model;            /**<酒店id*/
@end
