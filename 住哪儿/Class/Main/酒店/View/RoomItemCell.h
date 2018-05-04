//
//  RoomItemCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomItemCell;
@protocol RoomItemCellDelegate <NSObject>

-(void)roomItemCell:(RoomItemCell *)cell didBookRoom:(BOOL)flag price:(NSString *)price;

@end
@interface RoomItemCell : UITableViewCell
@property (nonatomic, weak) id<RoomItemCellDelegate> delegate;
@property (nonatomic, strong) NSString *price;            /**<价格*/
@property (nonatomic, strong) NSString *priceType;            /**<价格种类*/
@end
