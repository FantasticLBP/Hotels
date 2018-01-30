//
//  UnpayedOrderViewController.h
//  幸运计划助手
//
//  Created by 杭城小刘 on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"

@interface ExpiredOrderViewController : UIViewController

@property (nonatomic, assign) OrderType type;

-(void)reloadData;

@end
