//
//  PayOrderViewController.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
#import "HotelsModel.h"

@interface PayOrderViewController : UIViewController
@property (nonatomic, strong) RoomModel *model;            /**<房间数据*/
@property (nonatomic, strong) HotelsModel *hotelmodel;            /**<酒店数据*/
@property (nonatomic, strong) NSString *startPeriod;            /**<入住时间*/
@property (nonatomic, strong) NSString *leavePerios;            /**<离开时间*/
@property (nonatomic, strong) NSString *livingPeriod;            /**<住宿时间*/
@property (nonatomic, strong) NSString *orderId;            /**<订单id*/
@end
