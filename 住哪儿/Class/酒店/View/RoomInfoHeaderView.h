//
//  RoomInfoHeaderView.h
//  住哪儿
//
//  Created by geek on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RoomOperationType){
    RoomOperationType_MoreInfo,             /**<查看更多信息*/
    RoomOperationType_MorePhoto             /**<查看更多图片*/
};

@class RoomInfoHeaderView;
@protocol RoomInfoHeaderViewDelegate <NSObject>
-(void)roomInfoHeaderView:(RoomInfoHeaderView *)roomInfoHeaderView didOperateWithTag:(RoomOperationType)type;

@end
@interface RoomInfoHeaderView : UIView

@property (nonatomic, weak) id<RoomInfoHeaderViewDelegate> delegate;    /**<酒店房型操作*/

@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *roomImageName;
@property (nonatomic, strong) NSString *otherInfo;            /**<其他信息*/
@end
