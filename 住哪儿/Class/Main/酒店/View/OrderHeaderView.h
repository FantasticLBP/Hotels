//
//  OrderHeaderView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,OrderHeaderType){
    OrderHeaderType_Order,
    OrderHeaderType_Pay
};

@interface OrderHeaderView : UIView
@property (nonatomic, strong) NSString *hotelName;             /**<酒店名称*/
@property (nonatomic, strong) NSString *chechinTime;           /**<入驻时间*/
@property (nonatomic, strong) NSString *checkoutTime;          /**<离店时间*/
@property (nonatomic, strong) NSString *totalNight;            /**<共几晚*/
@property (nonatomic, strong) NSString *roomDetail;            /**<酒店详情*/
@property (nonatomic, assign) OrderHeaderType type;
@end
