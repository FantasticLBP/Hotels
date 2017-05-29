//
//  ObjectUtil.h
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectUtil : NSObject

+ (BOOL)isNull:(id)object;

+ (BOOL)isNotNull:(id)object;

+ (BOOL)isEmpty:(id)object;

+ (BOOL)isNotEmpty:(id)object;

+ (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key;
+ (NSNumber*)getNumberValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (double)getFloatValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (double)getDoubleValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (short)getShortValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (NSInteger)getIntegerValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (long long)getLonglongValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (void)setStringValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSString *)val;

+ (void)setDoubleValue:(NSDictionary *)dictionary key:(NSString *)key val:(double)val;

+ (void)setShortValue:(NSDictionary *)dictionary key:(NSString *)key val:(short)val;

+ (void)setIntegerValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSInteger)val;

+ (void)setLongLongValue:(NSDictionary *)dictionary key:(NSString *)key val:(long long)val;
+ (void)setNumberValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSNumber*)val;

@end
