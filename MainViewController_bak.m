//
//  MainViewController.m
//  幸运计划助手
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
#import "BadNetworkView.h"

@interface MainViewController ()
@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) FindViewController *messageVC;
@property (nonatomic, strong) ShakeViewController *shakeVC;
@property (nonatomic, strong) SettingViewController *settingVC;
@property (nonatomic, strong) OrderViewController *orderVC;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) NSString *jumpUrl;
@end

@implementation MainViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchFlagSuccess:^{
        [self.view addSubview:self.webview];
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jumpUrl]]];
    } fail:^{
        LBPNavigationController *homeNav=[[LBPNavigationController alloc]initWithRootViewController:self.homeVC];
        [self createVC:self.homeVC Title:@"首页" imageName:@"tabBar_home"];
        
        LBPNavigationController *messageVC=[[LBPNavigationController alloc]initWithRootViewController:self.messageVC];
        [self createVC:self.messageVC Title:@"发现" imageName:@"tabBar_discover"];
        
        LBPNavigationController *orderVC=[[LBPNavigationController alloc]initWithRootViewController:self.orderVC];
        [self createVC:self.orderVC Title:@"订单" imageName:@"tabBar_order"];
        
        LBPNavigationController *settingVC=[[LBPNavigationController alloc]initWithRootViewController:self.settingVC];
        [self createVC:self.settingVC Title:@"我的" imageName:@"tabBar_owner"];
        self.viewControllers = @[homeNav,messageVC,orderVC,settingVC];
        [[UITabBar appearance] setTranslucent:NO];
    }];
}



#pragma mark - private method

- (void)fetchFlagSuccess:(void(^)())success fail:(void(^)())fail {
    NSString *judgeUrl = @"http://vipapp.01appkkk.com/Lottery_server/get_init_data.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appid"] = @"com.luck.hotels";
    params[@"type"] = @"ios";
    [AFNetPackage getJSONWithUrl:judgeUrl parameters:params success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([json[@"rt_code"] integerValue] == 200) {
            NSDictionary *judgeDict = [ProjectUtil base64decode:json[@"data"]];
            self.jumpUrl = judgeDict[@"url"];
            BOOL needJump = [judgeDict[@"show_url"] boolValue];
            if (needJump) {
                if (success) {
                    success();
                }
            } else {
                if (fail) {
                    fail();
                }
            }
        } else {
            if (fail) {
                fail();
            }
        }
    } fail:^{
        if (fail) {
            fail();
        }
    }];
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

- (UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, BoundWidth, BoundHeight)];
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scrollView.contentInset = UIEdgeInsetsMake([ProjectUtil isPhoneX] ? 44 : 20, 0, [ProjectUtil isPhoneX] ? 20 : 0, 0);
    }
    return _webview;
}
@end
