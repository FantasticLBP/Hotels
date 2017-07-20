
//
//  ProjectUtil.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ProjectUtil.h"

@implementation ProjectUtil

+(BOOL)isBlank:(NSString*)source{
    if(source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

+(BOOL)isNotBlank:(NSString*)source{
    if(source == nil || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    return YES;
}


+(CGFloat)measureLabelWidth:(NSString *)titleStr withFontSize:(CGFloat)fontSize{
    if ([ProjectUtil isBlank:titleStr]) {
        return 0.0;
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]};
    CGSize size=[titleStr sizeWithAttributes:attrs];
    return size.width;
}

+(void)saveCityName:(NSString *)city{
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
}

+(NSString *)getCityName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
}

+(void)saveFirstCityName:(NSString *)city{
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"firctcity"];
}

+(NSString *)getFirstCityName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"firctcity"];
}



+(NSString *)getSubject:(NSInteger )type{
    NSString *result ;
    switch (type) {
        case 1:
            result = @"精品名宿";
            break;
        case 2:
            result = @"茶园野趣";
            break;
        case 3:
            result = @"景点周边";
            break;
        case 4:
            result = @"城市周边";
            break;
        case 5:
            result = @"公园之畔";
            break;
        case 6:
            result = @"温泉酒店";
            break;
        case 7:
            result = @"背包客栈";
            break;
        case 8:
            result = @"轻奢";
            break;
        case 9:
            result = @"新开酒店";
            break;
        case 10:
            result = @"高端酒店";
            break;
        case 11:
            result = @"度假酒店";
            break;
        case 12:
            result = @"亲子酒店";
            break;
        case 13:
            result = @"情侣酒店";
            break;
        case 14:
            result = @"山水酒店";
            break;
            
            
        default:
            break;
    }
    return result;
}


+(NSString *)dateFormateWithString:(NSString *)date{
    if ([ProjectUtil isBlank:date]) {
        return @"";
    }
    NSString *month = [date substringToIndex:2];
    NSString *day = [date substringWithRange:NSMakeRange(3, 2)];
    return [NSString stringWithFormat:@"%@-%@",month,day];
}


+(void)saveLocalnotificationWithKey:(NSString *)key{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:key];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:LocalNitificationArray];
}

+(NSMutableArray *)getLocalNitifications{
    NSMutableArray *array = [NSMutableArray array];
    array = [[NSUserDefaults standardUserDefaults] objectForKey:LocalNitificationArray];
    return array;
}

@end
