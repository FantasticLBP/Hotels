//
//  PriceAndStarLevelPickerView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/2/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PriceAndStarLevel_Operation_clearCondition = 0,             //清空选择
    PriceAndStarLevel_Operation_OK                              //确定选择
}PriceAndStarLevel_Operation;

typedef enum{
    Hotel_Star_Level_No = 0,        //不限
    Hotel_Star_Level_Cheap,         //经济
    Hotel_Star_Level_ThreeStar,     //三星
    Hotel_Star_Level_FourStar,      //四星
    Hotel_Star_Level_FiveStar       //五星
}Hotel_Star_Level;

typedef enum{
    Hotel_Price_Level_Zero          = 0,                  //0元
    Hotel_Star_Level_Fifty          = 50,                 //50元
    Hotel_Star_Level_Hundred        = 100,                //100元
    Hotel_Star_Level_HundredFifty   = 150,                //150元
    Hotel_Star_Level_TwoHundred     = 200,                //200元
    Hotel_Star_Level_TwoHundredFifty= 250,                //250
    Hotel_Star_Level_ThreeHundred   = 300,                //300
    Hotel_Star_Level_ThreeHundredFifty=350,               //350
    Hotel_Star_Level_FourHundred      =400,               //400
    Hotel_Star_Level_NoLimit                              //不限
}Hotel_Price_Level;

@class PriceAndStarLevelPickerView;
@protocol PriceAndStarLevelPickerViewDelegate <NSObject>

@required
-(void)priceAndStarLevelPickerView:(PriceAndStarLevelPickerView *)view didClickWithhButtonType:(PriceAndStarLevel_Operation)type withData:(NSMutableDictionary *)data;


@end
@interface PriceAndStarLevelPickerView : UIView
@property (nonatomic, weak) id<PriceAndStarLevelPickerViewDelegate> delegate;

-(void)refreshUI;           /**<界面刷新*/
@end
