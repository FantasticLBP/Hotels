//
//  UILabel+Helper.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/19.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

/**
 * 单例该对象
 */
+(UILabel *)sharedInstance;

/**
 *
 */
-(UILabel *)initInFrame:(CGRect *)rect;
@end
