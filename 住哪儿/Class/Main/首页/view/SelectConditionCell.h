//
//  SelectConditionCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/9.
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
