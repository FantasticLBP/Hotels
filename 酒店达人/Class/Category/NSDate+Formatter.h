//
//  NSDate+Formatter.h
//  酒店达人
//
//  Created by geek on 2016/12/19.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

/**
 * 单例该对象
 */
+(NSDate *)sharedInstance;

/**
 * 格式化输出
 * eg:12月8号今天
 */
-(NSString *)today;
@end
