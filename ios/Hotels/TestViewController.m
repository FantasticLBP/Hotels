
//
//  TestViewController.m
//  Hotels
//
//  Created by 杭城小刘 on 6/26/19.
//  Copyright © 2019 @杭城小刘. All rights reserved.
//

#import "TestViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTEventEmitter.h>

@interface TestViewController ()



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRCTRootView];
}


- (void)initRCTRootView
{
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://10.17.64.169:8081/index.bundle?plateform=ios&dev=true"];
//    NSDictionary *info = @{@"scores": @[
//                                   @{@"name": @"LBP",
//                                     @"value": @"42"
//                                     },
//                                   @{@"name": @"John",
//                                     @"value": @"40"npm
//                                     },
//                                   ]};
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"App" initialProperties:nil launchOptions:nil];
    self.view = rootView;
}

@end
