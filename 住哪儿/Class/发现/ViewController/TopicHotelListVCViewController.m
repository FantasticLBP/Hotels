


//
//  TopicHotelListVCViewController.m
//  住哪儿
//
//  Created by geek on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelListVCViewController.h"
#import "LBPNavigationController.h"
#import "FilterHotelVC.h"

@interface TopicHotelListVCViewController ()

@end

@implementation TopicHotelListVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"精品民宿";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.title = @"切换主题";
        right.target = self;
        right.action = @selector(filterTheHotel);
        right;
    });
}

-(void)filterTheHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.topic = ^(NSString *type){
        NSLog(@"选择了%@",type);
        NSLog(@"等待刷新列表");
    };
    
    LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];

}
@end
