//
//  OrderViewController.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController


/**
 * 根据scrollview滚动的偏移量判断显示哪个vc
 */
-(void)showButtonWithIndex:(NSInteger)index;
@end
