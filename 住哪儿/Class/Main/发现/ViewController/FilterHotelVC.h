//
//  FilterHotelVC.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedTheTopic)(NSString *subjectType,NSString *subjectName);

@interface FilterHotelVC : UIViewController
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, copy) SelectedTheTopic topic;
@end
