//
//  RoomBaseInfoView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomBaseInfoView : UIView

/**
 * 酒店房间基本信息View
 *
 *
 * @params image 图片名称
 * @params text 文字
 */
-(void)initViewWithImageName:(NSString *)image andLabelText:(NSString *)text;
@end
