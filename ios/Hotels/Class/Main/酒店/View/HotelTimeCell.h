//
//  HotelTimeCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTimeCell : UITableViewCell
@property (nonatomic, strong) NSString *startPeriod;            /**<入住时间*/
@property (nonatomic, strong) NSString *leavePerios;            /**<离开时间*/
@end
