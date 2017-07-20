//
//  Hotels.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/2/25.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "HotelsModel.h"


@implementation HotelsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"hotelId" : @"id"};
}

@end
