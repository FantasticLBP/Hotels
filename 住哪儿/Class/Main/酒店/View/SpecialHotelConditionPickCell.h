//
//  SpecialHotelConditionPickCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionPickerView.h"
@class SpecialHotelConditionPickCell;

@protocol SpecialHotelConditionPickCellDelegate <NSObject>

-(void)specialHotelConditionPickCell:(SpecialHotelConditionPickCell *)cell didClickWithAxctionType:(Operation_Type)type;

@end
@interface SpecialHotelConditionPickCell : UITableViewCell

@property (nonatomic, weak) id<SpecialHotelConditionPickCellDelegate> delegate;

@property (nonatomic, strong) NSString *selectedCity;            /**<选择城市*/
@end
