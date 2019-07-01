//
//  HotelRoomPriceVC.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
#import "HotelsModel.h"

@interface HotelRoomPriceVC : UIViewController
@property (nonatomic, strong) NSString *startPeriod;            /**<入住时间*/
@property (nonatomic, strong) NSString *leavePerios;            /**<离开时间*/
@property (nonatomic, strong) RoomModel *model;            /**<房屋model  */
@property (nonatomic, strong) HotelsModel *hotelModel;            /**<酒店id*/
@end
