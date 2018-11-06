//
//  OrderInfoCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/8.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInfoCell : UITableViewCell
@property (nonatomic, strong) NSString *orderNumber;        /**<订单号*/
@property (nonatomic, strong) NSString *hotelName;          /**<酒店名称*/
@property (nonatomic, strong) NSString *roomType;           /**<房间类型*/
@property (nonatomic, strong) NSString *livingPeriods;       /**<入住日期*/
@end
