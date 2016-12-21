
//
//  UserInfo.m
//  KSGuidViewDemo
//
//  Created by geek on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
-(id)init{
    if (self = [super init]) {
        self.userName = @"";
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.userName = dic[@"username"];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"username:%@",self.userName];
}
@end
