//
//  OrderFillFooterView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderFillFooterView;
@protocol OrderFillFooterViewDelegate <NSObject>

-(void)orderFillFooterView:(OrderFillFooterView *)view didClickPayButton:(BOOL)flag;

@end
@interface OrderFillFooterView : UIView
@property (nonatomic, strong) NSString *price;
@property (nonatomic, weak) id<OrderFillFooterViewDelegate> delegate;
@end
