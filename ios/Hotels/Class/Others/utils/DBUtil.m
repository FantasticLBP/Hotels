//
//  DBUtil.m
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/21.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "DBUtil.h"

@implementation DBUtil

+ (void)saveUserphone:(NSString *)phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"UserPhone"];
}

+ (NSString *)getUserphone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPhone"];
}


+ (void)saveUseremail:(NSString *)email{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"UserEmail"];
}

+ (NSString *)getUseremail{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmail"];
}

+ (void)savePublicReportTemplateVersion:(NSString *)version;{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"PublicReportTemplateVersion"];
}

+ (NSString *)getPublicReportTemplateVersion{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"PublicReportTemplateVersion"];
}


+ (void)saveProfessionalReportTemplateVersion:(NSString *)version{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"ProfessionalReportTemplateVersion"];
}

+ (NSString *)getProfessionalReportTemplateVersion{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfessionalReportTemplateVersion"];
}

+ (void)saveInviteCode:(NSString *)invitecode{
    [[NSUserDefaults standardUserDefaults] setObject:invitecode forKey:@"InviteCode"];
}

+ (NSString *)fetchInvitecode{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"InviteCode"];
}

+ (void)setLaunched:(BOOL)launched{
    [[NSUserDefaults standardUserDefaults] setBool:launched forKey:@"AppLaunched"];
}


+ (BOOL)isLaunched{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"AppLaunched"];
}


+ (void)saveDeviceID:(NSString *)deviceId{
    [[NSUserDefaults standardUserDefaults] setValue:deviceId forKey:@"NotificationId"];
}

+ (NSString *)fetchDeviceId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationId"];
}


+ (void)saveFunctionModules:(NSMutableArray *)functionModules{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:functionModules];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"BBXFunctionModules"];
}

+ (NSMutableArray *)fetchFunctionModules{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"BBXFunctionModules"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
