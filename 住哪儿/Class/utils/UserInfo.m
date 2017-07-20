
//
//  UserInfo.m
//  KSGuidViewDemo
//
//  Created by 杭城小刘 on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "UserInfo.h"
#import "YYModel.h"
@implementation UserInfo
-(id)init{
    if (self = [super init]) {
        self.id = @"";
        self.nickname = @"";
        self.password = @"";
        self.gender = @"";
        self.birthday = @"";
        self.avator = [[UIImage alloc] init];
        self.telephone = @"";
        self.name = @"";
        self.account = @"";
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.id = dic[@"id"];
        self.nickname = dic[@"nickname"];
        self.password = dic[@"password"];
        self.gender = dic[@"gender"];
        self.birthday = dic[@"birthday"];
        self.avator = dic[@"avator"];
        self.telephone = dic[@"telephone"];
        self.name = dic[@"name"];
        self.account = dic[@"account"];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"id:%@,nickname:%@,gender:%@,birthday:%@,avator:%@,password:%@,name=%@,telephone:%@,account:%@",self.id,self.nickname,self.gender,self.birthday,self.avator,self.password,self.name,self.telephone,self.account];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
