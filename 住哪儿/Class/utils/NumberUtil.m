//
//  NumberUtil.m
//  CardApp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "NumberUtil.h"

#define ZERO 0.000005

@implementation NumberUtil

+ (BOOL)isZero:(double)num
{
    return fabs(num)<ZERO;
}

+ (BOOL)isNotZero:(double)num
{
    return fabs(num)>ZERO;
}

+ (BOOL)isEqualNum:(double)num1 num2:(double)num2
{
    return [NumberUtil isZero:(num1-num2)];
}

+ (BOOL)isNotEqualNum:(double)num1 num2:(double)num2
{
    return [NumberUtil isNotZero:(num1-num2)];
}

@end
