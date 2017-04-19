//
//  NumberUtil.h
//  CardApp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberUtil : NSObject

+ (BOOL)isZero:(double)num;

+ (BOOL)isNotZero:(double)num;

+ (BOOL)isEqualNum:(double)num1 num2:(double)num2;

+ (BOOL)isNotEqualNum:(double)num1 num2:(double)num2;

@end
