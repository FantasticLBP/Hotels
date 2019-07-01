//
//  ConditionPickerView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/8.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    Operation_Type_InTime = 0,          //选择入住时间
    Operation_Type_EndTime,             //选择离店时间
    Operation_Type_AutoLocate,          //选择自己定位
    Operation_Type_Locate,              //手动定位城市
    Operation_Type_SearchHotel,         //查找酒店
    Operation_Type_StarFilter           //星级检索
    
}Operation_Type;

@class ConditionPickerView;
@protocol ConditionPickerViewDelegate <NSObject>

@required
-(void)conditionPickerView:(ConditionPickerView *)view didClickWithActionType:(Operation_Type)type andPickedData:(NSMutableDictionary *)dic;

@end
@interface ConditionPickerView : UIView
@property (nonatomic, weak) id<ConditionPickerViewDelegate> delegate;
@property (nonatomic, strong) NSString *cityName;            /**<选择的城市*/
@property (nonatomic, strong) NSMutableDictionary *datas;            /**<酒店星级和酒店价格*/
@property (nonatomic, strong) NSDate *pickedEndTime;            /**<选择的结束时间*/
@end
