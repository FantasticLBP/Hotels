
//
//  UserInfo.m
//  KSGuidViewDemo
//
//  Created by geek on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "UserInfo.h"
#import "YYModel.h"
@implementation UserInfo
-(id)init{
    if (self = [super init]) {
        self.userName = @"";
        self.password = @"";
        self.gender = @"";
        self.birthday = @"";
        self.avator = [[UIImage alloc] init];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.userName = dic[@"username"];
        self.password = dic[@"password"];
        self.gender = dic[@"gender"];
        self.birthday = dic[@"birthday"];
        self.avator = dic[@"avator"];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"username:%@,gender:%@,birthday:%@,avator:%@,password:%@",self.userName,self.gender,self.birthday,self.avator,self.password];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
