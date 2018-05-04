//
//  FormatUtil.h
//  CardApp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatUtil : NSObject

+ (NSString *)formatInt:(double)value;

+ (NSString *)formatDouble:(double)value;

+ (NSString *)formatDouble2:(double)value;

+ (NSString *)formatDouble3:(double)value;

+ (NSString *)formatDouble4:(double)value;

+ (NSString *)formatDouble5:(double)value;

+ (NSString *)formatDouble6:(double)value;

+ (NSString *)formatNumber:(double)value;

+ (NSString *)formatDistance:(double)value;

//分割，千位分割，带逗号.
+ (NSString *)formatDoubleWithSeperator:(double)value;

//分割, 千位分割, 带逗号.
+ (NSString *)formatIntWithSeperator:(int)value;

@end
