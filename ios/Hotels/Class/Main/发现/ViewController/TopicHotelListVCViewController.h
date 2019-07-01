//
//  TopicHotelListVCViewController.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelsModel.h"
@interface TopicHotelListVCViewController : UIViewController
@property (nonatomic, strong) NSString *cityName;            /**<选择城市*/
@property (nonatomic, strong) NSString *type;            /**<选择酒店主题*/
@end
