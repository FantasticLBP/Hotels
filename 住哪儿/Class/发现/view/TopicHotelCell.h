//
//  TopicHotelCell.h
//  住哪儿
//
//  Created by geek on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicHotelCell;
@protocol TopicHotelCellDelegate <NSObject>

-(void)topicHotelCell:(TopicHotelCell *)topicHotelCell didSelectAtIndex:(NSInteger)index;

@end

@interface TopicHotelCell : UITableViewCell
@property (nonatomic, weak) id<TopicHotelCellDelegate> delegate;
@end
