//
//  UITableView+NoData.h
//  幸运计划助手
//
//  Created by 杭城小刘 on 2017/9/15.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NoData)


//给UITableView增加一个分类方法，用来在没有数据的时候显示默认信息
-(void)tableViewDisplayWithMsg:(NSString *)message ifNecessaryForCount:(NSUInteger)rowCount;

@end
