//
//  MainViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "MainViewController.h"
#import "LBPNavigationController.h"
#import "HomeViewController.h"
#import "ShakeViewController.h"
#import "FindViewController.h"
#import "SettingViewController.h"
#import "OrderViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) FindViewController *messageVC;
@property (nonatomic, strong) ShakeViewController *shakeVC;
@property (nonatomic, strong) SettingViewController *settingVC;
@property (nonatomic, strong) OrderViewController *orderVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LBPNavigationController *homeNav=[[LBPNavigationController alloc]initWithRootViewController:self.homeVC];
    [self createVC:self.homeVC Title:@"首页" imageName:@"tabBar_home"];
    
    LBPNavigationController *messageVC=[[LBPNavigationController alloc]initWithRootViewController:self.messageVC];
    [self createVC:self.messageVC Title:@"发现" imageName:@"tabBar_discover"];
    
    LBPNavigationController *shakeVC=[[LBPNavigationController alloc]initWithRootViewController:self.shakeVC];
    [self createVC:self.shakeVC Title:@"摇一摇" imageName:@"tabBar_shake"];
    
    LBPNavigationController *orderVC=[[LBPNavigationController alloc]initWithRootViewController:self.orderVC];
    [self createVC:self.orderVC Title:@"订单" imageName:@"tabBar_order"];

    LBPNavigationController *settingVC=[[LBPNavigationController alloc]initWithRootViewController:self.settingVC];
    [self createVC:self.settingVC Title:@"我的" imageName:@"tabBar_owner"];

    self.viewControllers = @[homeNav,messageVC,shakeVC,orderVC,settingVC];
}

#pragma mark - private method
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

-(FindViewController *)messageVC{
    if (!_messageVC) {
        _messageVC = [[FindViewController alloc] init];
        _messageVC.view.backgroundColor = TableViewBackgroundColor;
        _messageVC.title = @"发现";
    }
    return _messageVC;
}


-(ShakeViewController *)shakeVC{
    if (!_shakeVC) {
        _shakeVC = [[ShakeViewController alloc] init];
        _shakeVC.view.backgroundColor = [UIColor whiteColor];
        _shakeVC.title = @"摇一摇";
    }
    return _shakeVC;
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
