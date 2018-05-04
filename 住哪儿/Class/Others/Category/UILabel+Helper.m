//
//  UILabel+Helper.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/19.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

+(UILabel *)sharedInstance{
    static UILabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UILabel alloc] init];
    });
    return instance;
}


-(UILabel *)initInFrame:(CGRect *)rect{
    UILabel *label = [UILabel sharedInstance];
    
    return label;
}

@end
