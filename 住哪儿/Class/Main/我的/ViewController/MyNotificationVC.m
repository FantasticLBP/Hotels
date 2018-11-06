
//
//  MyNotificationVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/11/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "MyNotificationVC.h"

@interface MyNotificationVC ()

@end

@implementation MyNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}


#pragma mark - Private method
-(void)setupUI{
    self.title = @"我的通知";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

@end
