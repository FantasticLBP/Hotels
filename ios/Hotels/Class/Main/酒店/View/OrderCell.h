//
//  OrderCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef NS_ENUM(NSInteger, OrderType){
    OrderType_WillPay,              //待付款
    OrderType_UnWalk,               //未出行
    OrderType_UnEvaluate,           //待评价
    OrderType_History               //历史记录
};
typedef NS_ENUM(NSInteger, OrderButtonOperationType) {
    OrderButtonOperationType_Pay,                   //付款
    OrderButtonOperationType_Revoke,                //取消订单
    OrderButtonOperationType_Cancel,                //删除订单
    OrderButtonOperationType_Evaluate,              //评价
    OrderButtonOperationType_Remind,                //添加提醒
    OrderButtonOperationType_ReBook                 //再次预定

};
@class OrderCell;
@protocol OrderCellDelegte <NSObject>

-(void)orderCell:(OrderCell *)cell didClickButtonWithCellType:(OrderButtonOperationType)type withOrderModel:(OrderModel *)model;

@end
@interface OrderCell : UITableViewCell

@property (nonatomic, strong) OrderModel *model;          
@property (nonatomic, assign) OrderType type;             /**<订单种类*/
@property (nonatomic, weak) id<OrderCellDelegte> delegate;
@end
