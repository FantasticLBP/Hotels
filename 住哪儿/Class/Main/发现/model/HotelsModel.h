//
//  Hotels.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/2/25.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"


@interface HotelsModel : NSObject
@property (nonatomic, strong) NSString *address;            /**<酒店地址*/
@property (nonatomic, strong) NSString *decorateTime;            /**<装修时间*/
@property (nonatomic, strong) NSString *evaluationId;            /**<评价id*/
@property (nonatomic, assign) NSInteger hasMeetingRoom;            /**<是否有会议室*/
@property (nonatomic, assign) NSInteger hasPackage;            /**<是否可以存放行李*/
@property (nonatomic, assign) NSInteger hasParking;            /**<是否可以停车*/
@property (nonatomic, assign) NSInteger hasWifi;            /**<是否有wifi*/
@property (nonatomic, strong) NSString *hotelName;            /**<酒店名称*/
@property (nonatomic, strong) NSString *hotelId;            /**<酒店id*/
@property (nonatomic, strong) NSString *startTime;            /**<酒店开业时间*/
@property (nonatomic, assign) NSInteger subject;            /**<酒店主题*/
@property (nonatomic, strong) NSString *image1;
@property (nonatomic, strong) NSString *image2;
@property (nonatomic, strong) NSString *image3;
@property (nonatomic, strong) NSString *image4;
@property (nonatomic, strong) NSString *image5;
@property (nonatomic, strong) NSString *minPrice;            /**<价格*/
@property (nonatomic, strong) NSString *kindDescription;     /**<特色描述*/
@property (nonatomic, assign) NSInteger kindType;            /**<酒店类型*/
@property (nonatomic, assign) NSInteger stars;            /**<酒店星级*/



@end
