//
//  TopicHotelCell.h
//  幸运计划助手
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicHotelCell;
@protocol TopicHotelCellDelegate <NSObject>

-(void)topicHotelCell:(TopicHotelCell *)topicHotelCell didSelectAtIndex:(NSInteger)index andSubjectName:(NSString *)subjectName;

@end

@interface TopicHotelCell : UITableViewCell
@property (nonatomic, weak) id<TopicHotelCellDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *subjects;
@end
