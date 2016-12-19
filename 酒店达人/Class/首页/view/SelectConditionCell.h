//
//  SelectConditionCell.h
//  酒店达人
//
//  Created by geek on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectConditionCell;
@protocol SelectConditionCellDelegate <NSObject>
-(void)selectConditionCell:(SelectConditionCell *)selectConditionCell didClickCollectionCellAtIndexPath:(NSInteger)indexPath;
@end

@interface SelectConditionCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, weak) id<SelectConditionCellDelegate> delegate;

@end
