//
//  RoomModel.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/3/6.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomModel : NSObject
@property (nonatomic, assign) NSInteger roomId;                 /**<数据记录id*/
@property (nonatomic, assign) NSInteger hotelId;                /**<酒店id*/
@property (nonatomic, strong) NSString *type;                   /**<酒店类型*/
@property (nonatomic, assign) NSInteger znecancelPrice;         /**<住哪儿可取消价格*/
@property (nonatomic, assign) NSInteger znePrice;               /**<住哪儿不可取消价格*/
@property (nonatomic, assign) NSInteger delegatecancelPrice;    /**<代理可取消价格*/
@property (nonatomic, assign) NSInteger delegatePrice;          /**<代理不可取消价格*/
@property (nonatomic, assign) NSInteger hasWindow;              /**<有无窗户*/
@property (nonatomic, assign) NSInteger hasWifi;                /**<是否有wifi*/
@property (nonatomic, strong) NSString *equipmentCondtion;            /**<数据记录id*/
@property (nonatomic, strong) NSString *floor;            /**<数据记录id*/
@property (nonatomic, assign) NSInteger square;            /**<数据记录id*/
@property (nonatomic, strong) NSString *bedScale;            /**<数据记录id*/
@property (nonatomic, assign) NSInteger availablePerson;            /**<数据记录id*/
@property (nonatomic, assign) NSInteger roomCount;            /**<数据记录id*/
@property (nonatomic, strong) NSString *otherInfo;            /**<数据记录id*/
@property (nonatomic, assign) NSInteger rocountomId;            /**<数据记录id*/
@property (nonatomic, assign) NSInteger count;            /**<数据记录id*/
@property (nonatomic, strong) NSString *image1;            /**<数据记录id*/
@property (nonatomic, strong) NSString *image2;            /**<数据记录id*/
@property (nonatomic, strong) NSString *image3;            /**<数据记录id*/
@property (nonatomic, strong) NSString *image4;            /**<数据记录id*/
@property (nonatomic, strong) NSString *image5;            /**<数据记录id*/
@end
