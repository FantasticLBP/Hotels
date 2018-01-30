//
//  AppUpdater.h
//  幸运计划助手
//
//  Created by 杭城小刘 on 2018/1/4.
//  Copyright © 2018年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUpdater : NSObject

//单例对象
+(AppUpdater *)sharedAppUpdater;

//App移动后检查App是否需要升级
-(void)checkUpdate;

@end
