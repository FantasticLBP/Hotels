//
//  UIViewController+badNetwork.m
//  住哪儿
//
//  Created by 刘斌鹏 on 2018/11/5.
//  Copyright © 2018 geek. All rights reserved.
//

#import "UIViewController+badNetwork.h"

@implementation UIViewController (badNetwork)

- (void)viewWillAppear:(BOOL)animated {
    if (self.navigationController.viewControllers.count == 1) {
        [[BadNetworkView sharedInstance] monitorNetwork];
    }
}



@end
