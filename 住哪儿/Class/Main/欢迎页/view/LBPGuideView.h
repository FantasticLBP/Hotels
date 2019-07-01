//
//  LBPGuideView.h
//  立方查
//
//  Created by 杭城小刘 on 2018/4/5.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPGuideView : UIView

@property (nonatomic, strong) UIColor *pageControlCurrentColor;     /**<指示器选中颜色 默认主界面颜色 */
@property (nonatomic, strong) UIColor *pageControlNormalColor;      /**< 控制器默认颜色*/
@property (nonatomic, assign) BOOL pageControlHidden;               /**< 控制器是否隐藏，默认NO*/
@property (nonatomic, assign) BOOL enterButtonHidden;               /**< 进入按钮隐藏，默认NO。如果隐藏就在最后一页左滑进入主界面*/

+ (instancetype)showGuideViewWithImages:(NSArray<NSString *> *)imageNames;


@end
