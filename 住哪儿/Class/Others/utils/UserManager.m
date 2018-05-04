
//
//  UserManager.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/16.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager


+(BOOL)isLogin{
    BOOL loginState;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"1userObject"];
    if (data.length > 0) {
        loginState = YES;
    }else{
        loginState = NO;
    }
    return loginState;
}

+(void)saveUserObject:(UserInfo *)userinfo{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userinfo];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:[NSString stringWithFormat:@"%@userObject",@"1"]];
}

+(UserInfo *)getUserObject{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"1userObject"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data ];
}

+(void)logoOut{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"1userObject"];
}

@end
