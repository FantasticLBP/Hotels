//
//  MainViewController.m
//  酒店达人
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "LBPNavigationController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"
#import "OrderViewController.h"


@interface MainViewController ()
@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MessageViewController *messageVC;
@property (nonatomic, strong) SettingViewController *settingVC;
@property (nonatomic, strong) OrderViewController *orderVC;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LBPNavigationController *homeNav=[[LBPNavigationController alloc]initWithRootViewController:self.homeVC];
    [self createVC:self.homeVC Title:@"首页" imageName:@"shouye"];
    
    LBPNavigationController *messageVC=[[LBPNavigationController alloc]initWithRootViewController:self.messageVC];
    [self createVC:self.messageVC Title:@"消息" imageName:@"xiaoxi"];
    
    LBPNavigationController *orderVC=[[LBPNavigationController alloc]initWithRootViewController:self.orderVC];
    [self createVC:self.orderVC Title:@"订单" imageName:@"friend"];

    
    LBPNavigationController *settingVC=[[LBPNavigationController alloc]initWithRootViewController:self.settingVC];
    [self createVC:self.settingVC Title:@"我的" imageName:@"wode"];


    self.viewControllers = @[homeNav,messageVC,orderVC,settingVC];
}



-(void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName{
    vc.title = title;
    self.tabBar.tintColor = GlobalMainColor;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *imageSelect = [NSString stringWithFormat:@"%@_selected",imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect] imageWithRenderingMode:UIImageRenderingModeAutomatic];
}

#pragma mark -- lazy load
-(HomeViewController *)homeVC{
    if (!_homeVC) {
        _homeVC = [[HomeViewController alloc] init];
        _homeVC.view.backgroundColor = TableViewBackgroundColor;
        _homeVC.title = @"首页";
    }
    return _homeVC;
}


-(MessageViewController *)messageVC{
    if (!_messageVC) {
        _messageVC = [[MessageViewController alloc] init];
        _messageVC.view.backgroundColor = TableViewBackgroundColor;
        _messageVC.title = @"消息";
    }
    return _messageVC;
}

-(OrderViewController *)orderVC{
    if (!_orderVC) {
        _orderVC = [[OrderViewController alloc] init];
        _orderVC.view.backgroundColor = TableViewBackgroundColor;
        _orderVC.title = @"订单";
    }
    return _orderVC;
}

-(SettingViewController *)settingVC{
    if (!_settingVC) {
        _settingVC = [[SettingViewController alloc] init];
        _settingVC.view .backgroundColor = TableViewBackgroundColor;
        _settingVC.title = @"我的";
    }
    return _settingVC;
}
@end
