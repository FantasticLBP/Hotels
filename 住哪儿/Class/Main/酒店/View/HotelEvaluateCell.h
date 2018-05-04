//
//  HotelEvaluateCell.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelEvaluateCell : UITableViewCell
-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag;
@property (nonatomic, assign) BOOL hidden;
@end
