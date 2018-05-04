//
//  HotelKindCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"

@interface HotelKindCell : UITableViewCell
@property (nonatomic, strong) RoomModel *roomModel;            /**<房间model*/
@end
