//
//  PriceAndStarLevelPickerView.h
//  住哪儿
//
//  Created by geek on 2017/2/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PriceAndStarLevel_Operation_clearCondition = 0,             //清空选择
    PriceAndStarLevel_Operation_OK                              //确定选择
}PriceAndStarLevel_Operation;

@class PriceAndStarLevelPickerView;
@protocol PriceAndStarLevelPickerViewDelegate <NSObject>

@required
-(void)priceAndStarLevelPickerView:(PriceAndStarLevelPickerView *)view didClickWithhButtonType:(PriceAndStarLevel_Operation)type;


@end
@interface PriceAndStarLevelPickerView : UIView

@property (nonatomic, weak) id<PriceAndStarLevelPickerViewDelegate> delegate;
@end
