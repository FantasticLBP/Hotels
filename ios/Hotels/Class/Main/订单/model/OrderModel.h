//
//  OrderModel.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/3/12.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomModel.h"
#import "YYModel.h"
#import "HotelsModel.h"

@interface OrderModel : NSObject
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *hotelId;
@property (nonatomic, strong) NSString *linkman;
@property (nonatomic, strong) NSString *livingPeriod;
@property (nonatomic, strong) NSString *merberId;
@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSArray<RoomModel *>* room;
@property (nonatomic, strong) NSArray<HotelsModel *>* hotel;

@end
