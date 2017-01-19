//
//  UserInfo.h
//  KSGuidViewDemo
//
//  Created by geek on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic, strong) NSString *userName;            /**<用户名*/
@property (nonatomic, strong) NSString *gender;               /**<性别*/
@property (nonatomic, strong) NSString *birthday;            /**<出生日期*/
@property (nonatomic, strong) NSString *password;            /**<用户密码*/
@property (nonatomic, strong) UIImage *avator;               /**<用户头像*/


-(id)initWithDictionary:(NSDictionary *)dic;

@end
