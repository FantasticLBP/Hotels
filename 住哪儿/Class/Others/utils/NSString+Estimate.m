//
//  NSString+Estimate.m
//  retailapp
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "NSString+Estimate.h"
#import "RegexKitLite.h"

@implementation NSString (Estimate)


+ (BOOL)isNotBlank:(NSString*)source
{
    if(source == nil || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isBlank:(NSString*)source
{
    if(source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

//非0正整数验证.
+(BOOL) isNumNotZero:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

//正整数验证(带0).
+(BOOL) isPositiveNum:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^[1-9]\\d*|0$";
    return [source isMatchedByRegex:format];
}


//整数验证.
+(BOOL) isInt:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^-?[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

//小数正验证.
+(BOOL) isFloat:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    if ([NSString isPositiveNum:source]) {
        return YES;
    }
    NSString* format=@"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}




//包换不是数字英文字母验证.
+(BOOL) isNotNumAndLetter:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return YES;
    }
    NSString* format=@"[^a-zA-Z0-9]+";
    return [source isMatchedByRegex:format];
}

//日期验证.
+(BOOL) isDate:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} CST$";
    return [source isMatchedByRegex:format];
}

//URL路径过滤掉随机数.
+(NSString*) urlFilterRan:(NSString*)urlPath
{
    NSString *regex = @"(.*)([\\?|&]ran=[^&]+)";
    return [urlPath stringByReplacingOccurrencesOfRegex:regex withString:@"$1"];
}

+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    retStr=[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [retStr lowercaseString];
}

//验证Email是否正确.
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end
