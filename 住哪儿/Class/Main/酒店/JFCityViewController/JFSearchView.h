//
//  JFSearchView.h
//  JFFootball
//
//  Created by 张志峰 on 2016/11/24.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JFSearchViewChoseCityReultBlock)(NSDictionary *cityData);
typedef void(^JFSearchViewBlock)();

@interface JFSearchView : UIView

/** 搜索结果*/
@property (nonatomic, strong) NSMutableArray *resultMutableArray;

@property (nonatomic, copy) JFSearchViewChoseCityReultBlock resultBlock;
@property (nonatomic, copy) JFSearchViewBlock touchViewBlock;


/**
 点击搜索结果回调函数

 @param block 回调
 */
- (void)resultBlock:(JFSearchViewChoseCityReultBlock)block;


/**
 点击空白View回调，取消搜索

 @param block 回调
 */
- (void)touchViewBlock:(JFSearchViewBlock)block;


@end
