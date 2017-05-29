//
//  AppDelegate.m
//  住哪儿
//
//  Created by geek on 2016/11/15.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>



@interface AppDelegate (){
    BMKMapManager * _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"LYHkYVQGWmQxKZw7O62P24Cj1aCovpuN" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed");
    }
    return YES;
}


/**
 只有当发送出一个本地通知, 并且满足以下条件时, 才会调用该方法
 APP 处于前台情况
 当用用户点击了通知, 从后台, 进入到前台时,
 当锁屏状态下, 用户点击了通知, 从后台进入前台
 
 注意: 当App彻底退出时, 用户点击通知, 打开APP , 不会调用这个方法
 
 但是会把通知的参数传递给 application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
 
 */

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    notification.applicationIconBadgeNumber = 0;
    MainViewController *vc = (MainViewController *)[UIApplication sharedApplication] .keyWindow.rootViewController;
    vc.selectedIndex = 2;
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    // 查看当前的状态出于(前台: 0)/(后台: 2)/(从后台进入前台: 1)
    NSLog(@"applicationState.rawValue: %zd", application.applicationState);
    
    // 执行响应操作
    // 如果当前App在前台,执行操作
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"执行前台对应的操作");
    } else if (application.applicationState == UIApplicationStateInactive) {
        // 后台进入前台
        NSLog(@"执行后台进入前台对应的操作");
        NSLog(@"*****%@", notification.userInfo);
    } else if (application.applicationState == UIApplicationStateBackground) {
        // 当前App在后台
        
        NSLog(@"执行后台对应的操作");
    }
}






//监听通知操作行为的点击
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    NSLog(@"监听通知操作行为的点击");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
