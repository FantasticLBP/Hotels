//
//  HotelOrderFillVC.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelsModel.h"
#import "RoomModel.h"

@interface HotelOrderFillVC : UIViewController
@property (nonatomic, strong) NSString *startPeriod;            /**<入住时间*/
@property (nonatomic, strong) NSString *leavePerios;            /**<离开时间*/
@property (nonatomic, strong) HotelsModel *model;            /**<酒店数据*/
@property (nonatomic, strong) NSString *price;            /**<支付金额*/
@property (nonatomic, strong) RoomModel *roomModel;
@end
