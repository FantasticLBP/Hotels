//
//  DBUtil.h
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/21.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtil : NSObject

/**
 保存用户登录手机号
 
 @param phone 手机号
 */
+(void)saveUserphone:(NSString *)phone;

/**
 获取用户登录手机号
 
 @return 手机号
 */
+(NSString *)getUserphone;


/**
 保存用户邮箱

 @param email 邮箱
 */
+ (void)saveUseremail:(NSString *)email;

/**
 获取用户输入过的邮箱

 @return 邮箱
 */
+ (NSString *)getUseremail;

/**
 保存公众版报告模版版本号
 
 @param version 版本号
 */
+ (void)savePublicReportTemplateVersion:(NSString *)version;

/**
 获取公众版报告模版版本号
 
 @return 版本号
 */
+ (NSString *)getPublicReportTemplateVersion;


/**
 保存专业版报告模版版本号
 
 @param version 版本号
 */
+ (void)saveProfessionalReportTemplateVersion:(NSString *)version;

/**
 获取专业版报告模版版本号
 
 @return 版本号
 */
+ (NSString *)getProfessionalReportTemplateVersion;


/**
 存储用户邀请码
 
 @param invitecode 邀请码
 */
+ (void)saveInviteCode:(NSString *)invitecode;

/**
 获取用户邀请码
 
 @return 邀请码
 */
+ (NSString *)fetchInvitecode;

/**
 设置第一次启动

 @param launched 第一次启动yu f
 */
+ (void)setLaunched:(BOOL)launched;

//是否为第一次启动
+ (BOOL)isLaunched;

//存储deviceid
+ (void)saveDeviceID:(NSString *)deviceId;

//获取 deviceid
+ (NSString *)fetchDeviceId;

//保存百宝箱功能模块
+ (void)saveFunctionModules:(NSMutableArray *)functionModules;

//获取用户自定义的百宝箱功能模块
+ (NSMutableArray *)fetchFunctionModules;




@end
