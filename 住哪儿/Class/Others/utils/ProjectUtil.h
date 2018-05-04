//
//  ProjectUtil.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectUtil : NSObject
/**
 * @brief 判断字符串为空
 *
 */
+(BOOL)isBlank:(NSString*)source;

/**
 * @brief 判断字符串不为空
 *
 */
+(BOOL)isNotBlank:(NSString*)source;

/**
 * @brief 根据传入字符串内容返回宽度
 *
 * params: titleStr 字符串内容
 *
 * params: fontSize 文字大小
 */
+(CGFloat)measureLabelWidth:(NSString *)titleStr withFontSize:(CGFloat)fontSize;

/**
 * 存储选取城市
 */
+(void)saveCityName:(NSString *)city;
/**
 * 获取选取城市
 */
+(NSString *)getCityName;


+(void)saveFirstCityName:(NSString *)city;
+(NSString *)getFirstCityName;

/**
 * 根据type获取主题名称
 */
+(NSString *)getSubject:(NSInteger )type;


/**
 * 根据输入字符串格式化输出“MM-dd”的日期
 */

+(NSString *)dateFormateWithString:(NSString *)date;

/**
 * 保存本地通知名
 */
+(void)saveLocalnotificationWithKey:(NSString *)key;

/**
 * 获得本地通知名
 */
+(NSMutableArray *)getLocalNitifications;
@end

