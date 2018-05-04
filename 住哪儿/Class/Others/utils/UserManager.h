//
//  UserManager.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/16.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserManager : NSObject
@property (nonatomic, strong) UserInfo *userInfo;


/**
 *  判断是否处于登录状态
 */
+(BOOL)isLogin;

/**
 *  存储用户基本信息
 */
+(void)saveUserObject:(UserInfo *)userinfo;

/**
 *  获取用户基本信息
 */
+(UserInfo *)getUserObject;

/**
 *  退出登录，清除用户信息
 */
+(void)logoOut;

@end
