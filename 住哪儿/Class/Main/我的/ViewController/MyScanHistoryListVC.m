

//
//  MyScanHistoryListVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/11/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "MyScanHistoryListVC.h"

@interface MyScanHistoryListVC ()

@end

@implementation MyScanHistoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}


#pragma mark - Private method
-(void)setupUI{
    self.title = @"浏览记录";
    self.view.backgroundColor = [UIColor whiteColor];
    
}
@end
