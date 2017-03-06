
//
//  HotelLocationMapVC.m
//  住哪儿
//
//  Created by geek on 2016/12/25.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelLocationMapVC.h"

@interface HotelLocationMapVC ()

@end

@implementation HotelLocationMapVC

#pragma mark - lice cyele

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SVProgressHUD showInfoWithStatus:@"地图功能正在开发中，敬请期待..."];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"酒店位置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    

}

#pragma mark - lazy load

@end
