//
//  NSObject+NSLocalNotification.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/3/14.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "NSObject+NSLocalNotification.h"
#import "AppDelegate.h"

#define DEVICE_iOS_8    [UIDevice currentDevice].systemVersion.floatValue >= 8.0
#define DEVICE_iOS_9    [UIDevice currentDevice].systemVersion.floatValue >= 9.0
@implementation NSObject (NSLocalNotification)

+ (void)registerLocalNotification:(NSInteger)time content:(NSString *)content key:(NSString *)key{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:time ];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = 0;
    localNotification.alertBody = content;
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:content forKey:key];
    localNotification.userInfo = userDict;
    [self getRequestWithLocalNotificationSleep:localNotification];
    
}

- (void)getRequestWithLocalNotificationSleep:(UILocalNotification *)notification
{
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
#warning 注册完之后如果不删除，下次会继续存在，即使从模拟器卸载掉也会保留
    
    //删除之前的通知
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

+ (void)cancelLocalNotificationWithKey:(NSString *)key{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    if (localNotifications) {
        
        
        for (UILocalNotification *notification in localNotifications) {
            NSDictionary *userInfo = notification.userInfo;
            if (userInfo) {
                // 根据设置通知参数时指定的key来获取通知参数
                NSString *info = userInfo[key];
                
                // 如果找到需要取消的通知，则取消
                if ([info isEqualToString:key]) {
                    if (notification) {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    }
                    break;
                }
            }
        }
        
    }
}


#pragma mark - 带有Action的通知

// iOS 8.0之后需主动请求授权
//带 Action 的 通知
- (void)requestAuthor
{
    if (DEVICE_iOS_8) {
        
        // ------------------------------------------------------------------------
        // 1.给通知设置一些操作行为.注意: 需先注册这些操作行为
        // 1.1 创建一个组
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        // 设置组的标识
        category.identifier = @"select";
        
        // ------------------------------------------------------------------------
        // 添加按钮1 "进入"
        // 1.2 创建操作行为
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        // 设置行为的标识
        action1.identifier = @"go";
        action1.title = @"进入";
        //        action1.behavior = nil;
        
        // 设置要在前台执行该行为
        action1.activationMode = UIUserNotificationActivationModeForeground;
        // 设置只有解锁之后才能执行
        //        action1.authenticationRequired = YES;
        // 设置这个操作是否是破坏性的行为(通过不同颜色来区别)
        action1.destructive = YES;
        
        // ------------------------------------------------------------------------
        // 添加按钮2 "回复"
        // 1.2 创建操作行为
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
        // 设置行为的标识
        action2.identifier = @"answer";
        action2.title = @"回复";
        // iOS 9.0之后才能弹出文本框,如果没判断,在9.0之前版本运行,程序会崩溃
        if (DEVICE_iOS_9) {
            action2.behavior = UIUserNotificationActionBehaviorTextInput;
        }
        
        // 设置要在后台执行该行为
        action2.activationMode = UIUserNotificationActivationModeBackground;
        
        // 设置这个是破坏性的行为(通过不同颜色来区别)
        action2.destructive = NO;
        
        // 将按钮1和按钮2添加到category
        NSArray *actions = @[action1, action2];
        [category setActions:actions forContext:UIUserNotificationActionContextDefault];
        
        // 将category封装为集合
        NSSet *categories = [NSSet setWithObjects:category, nil];
        
        
        // ------------------------------------------------------------------------
        // 授权通知
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:categories];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
}


//        //创建一个本地通知
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        //设置时区 跟随手机系统时区
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        //设置本地推送的时间
//        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
//        //设置锁屏状态下  “滑动XXX”
//        notification.hasAction =  YES;
//        //设置锁屏状态下的文字
//        notification.alertAction = @"锁屏状态文字";
//        //设置启动图片
//        notification.alertLaunchImage = @"1.jpg";
//        //设置音效
//        notification.soundName =  UILocalNotificationDefaultSoundName;
//        //设置应用图标 提醒数字
//        notification.applicationIconBadgeNumber = 1;
//        //设置弹出的内容
//        notification.alertBody = @"本地通知练习";
//        //设置userInfo 传递消息
//        notification.userInfo = @{@"alertBody":notification.alertBody,@"applicationIconBadgeNumber":@(notification.applicationIconBadgeNumber)};
//


@end
