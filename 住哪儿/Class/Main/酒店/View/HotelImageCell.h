//
//  HotelImageCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
#import "HotelsModel.h"

///酒店事件类型
typedef NS_ENUM(NSInteger,Hotel_Action_Type){
    Watch_Hotel_DetailImage,
    Watch_Hotel_Map
};

@class HotelImageCell;

@protocol HotelImageCellDelegate <NSObject>

-(void)hotelImageCell:(HotelImageCell *)hotelImageCell didOperateHotelWithType:(Hotel_Action_Type)type;

@end

@interface HotelImageCell : UITableViewCell
@property (nonatomic, strong) HotelsModel *hotelModel;
@property (nonatomic, strong) NSMutableArray *images;       /**<酒店轮播图*/
@property (nonatomic, weak) id<HotelImageCellDelegate> delegate;    /**<酒店事件代理*/
@end
