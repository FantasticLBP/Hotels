//
//  LocationManager.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/4/22.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocationManager;
@protocol LocationManagerDelegate <NSObject>

-(void)locationManager:(LocationManager *)locationManager didGotLocation:(NSString *)location;

@end

@interface LocationManager : NSObject

@property (nonatomic, assign) id<LocationManagerDelegate> delegate;

/**
 * 单例模式实例化对象
 */
+(LocationManager *)sharedInstance;
/**
 * 开始定位
 */
-(void)autoLocate;
@end
