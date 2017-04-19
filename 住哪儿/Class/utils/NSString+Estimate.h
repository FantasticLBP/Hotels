//
//  NSString+Estimate.h
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Estimate)

+ (BOOL)isNotBlank:(NSString*)source;

+ (BOOL)isBlank:(NSString*)source;

//正整数验证(带0).
+(BOOL) isPositiveNum:(NSString*)source;

+(BOOL) isNumNotZero:(NSString*)source;

+(BOOL) isNotNumAndLetter:(NSString*)source;

//整数验证.
+(BOOL) isInt:(NSString*)source;
//小数正验证.
+(BOOL) isFloat:(NSString*)source;

//日期验证.
+(BOOL) isDate:(NSString*)source;


//URL路径过滤掉随机数.
+(NSString*) urlFilterRan:(NSString*)urlPath;

+(NSString *)getUniqueStrByUUID;

//验证Email是否正确.
+ (BOOL)isValidateEmail:(NSString *)email;

@end
