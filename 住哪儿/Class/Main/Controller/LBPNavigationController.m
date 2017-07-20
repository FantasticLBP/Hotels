
//
//  LBPNavigationController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "LBPNavigationController.h"


@interface LBPNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LBPNavigationController

+ (void)initialize
{
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Lato-Regular" size:18], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSMutableDictionary *testAttr = [NSMutableDictionary dictionary];
    testAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    testAttr[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [[UINavigationBar appearance] setTitleTextAttributes:testAttr];
    
    testAttr = [NSMutableDictionary dictionary];
    testAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:testAttr forState:UIControlStateNormal];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@""]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:GlobalMainColor];
    // 设置pop手势的代理
//    self.interactivePopGestureRecognizer.delegate = self;
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIScreenEdgePanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = YES;
}

/**
 *  重写这个方法的目的:为了拦截整个push过程,拿到所有push进来的子控制器
 *
 *  @param viewController 当前push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    if (viewController != 栈底控制器) {
    if (self.viewControllers.count > 0) {
        // 当push这个子控制器时, 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"backArror"] forState:UIControlStateNormal];
        
        //        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        backButton.adjustsImageWhenHighlighted = NO;
        
        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    // 将viewController压入栈中
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  这个代理方法的作用:决定pop手势是否有效
 *
 *  @return YES:手势有效, NO:手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}


@end
