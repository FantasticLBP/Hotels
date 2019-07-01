//
//  JFCityViewController.h
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JFCityViewControllerBlock)(NSString *cityName);

@interface JFCityViewController : UIViewController

@property (nonatomic, copy) JFCityViewControllerBlock choseCityBlock;

/**
 选择城市后的回调

 @param block 回调
 */
- (void)choseCityBlock:(JFCityViewControllerBlock)block;

@end
