
//
//  ProjectUtil.m
//  住哪儿
//
//  Created by geek on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ProjectUtil.h"

@implementation ProjectUtil

+(BOOL)isBlank:(NSString*)source{
    if(source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

+(BOOL)isNotBlank:(NSString*)source{
    if(source == nil || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    return YES;
}


@end
