//
//  ProjectUtil.h
//  住哪儿
//
//  Created by geek on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectUtil : NSObject
/**
 * @brief 判断字符串为空
 *
 */
+(BOOL)isBlank:(NSString*)source;

+(BOOL)isNotBlank:(NSString*)source;

@end
