//
//  ObjectUtil.m
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//
#import "ObjectUtil.h"
#import "NSString+Estimate.h"

@implementation ObjectUtil

+ (BOOL)isNull:(id)object
{
    if (object == nil || object == [NSNull null]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNotNull:(id)object
{
    if (object != nil && object != [NSNull null]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmpty:(id)object
{
    if ([ObjectUtil isNull:object]) {
        return YES;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        return (array.count==0);
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        return (dictionary.count==0);
    }
    return NO;
}

+ (BOOL)isNotEmpty:(id)object
{
    if ([ObjectUtil isNotNull:object]) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)object;
            return (array.count>0);
        }
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)object;
            return (dictionary.count>0);
        }
    }
    return NO;
}


+ (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return object;
        }
    }
    return 0;
}
+ (NSNumber*)getNumberValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return object;
        }
    }
    return nil;
}

+ (double)getFloatValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object floatValue];
        }
    }
    return 0;
}

+ (double)getDoubleValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object doubleValue];
        }
    }
    return 0;
}

+ (short)getShortValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object shortValue];
        }
    }
    return 0;
}

+ (NSInteger)getIntegerValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object integerValue];
        }
    }
    return 0;
}

+ (long long)getLonglongValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object longLongValue];
        }
    }
    return 0;
}

+ (void)setStringValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSString *)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key] && [ObjectUtil isNotNull:val]) {
        [dictionary setValue:val forKey:key];
    }
}

+ (void)setDoubleValue:(NSDictionary *)dictionary key:(NSString *)key val:(double)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key]) {
        [dictionary setValue:[NSNumber numberWithDouble:val] forKey:key];
    }
}

+ (void)setShortValue:(NSDictionary *)dictionary key:(NSString *)key val:(short)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key]) {
        [dictionary setValue:[NSNumber numberWithShort:val] forKey:key];
    }
}

+ (void)setIntegerValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSInteger)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key]) {
        [dictionary setValue:[NSNumber numberWithInteger:val] forKey:key];
    }
}

+ (void)setLongLongValue:(NSDictionary *)dictionary key:(NSString *)key val:(long long)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key]) {
        [dictionary setValue:[NSNumber numberWithLongLong:val] forKey:key];
    }
}
+ (void)setNumberValue:(NSDictionary *)dictionary key:(NSString *)key val:(NSNumber*)val
{
    if ([ObjectUtil isNotNull:dictionary] && [ObjectUtil isNotNull:key]) {
        [dictionary setValue:val forKey:key];
    }
}

@end



