//
//  HotPopularHotelAdCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotPopularHotelAdCell;

@protocol HotPopularHotelAdCellDelegate <NSObject>
-(void)HotPopularHotelAdCell:(HotPopularHotelAdCell *)HotPopularHotelAdCell didClickCollectionCellAtIndexPath:(NSInteger)indexPath;
@end

@interface HotPopularHotelAdCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, weak) id<HotPopularHotelAdCellDelegate> delegate;

@end
