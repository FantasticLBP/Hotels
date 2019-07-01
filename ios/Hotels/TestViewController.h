//
//  TestViewController.h
//  Hotels
//
//  Created by 杭城小刘 on 6/26/19.
//  Copyright © 2019 @杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 打算接入 React Native 开发的页面。单纯新建的 RN 项目可以正常运行。但是将 RN 编写好的页面接入到已有的 iOS 工程，会报错（Module `AccessibilityInfo` does not exist in the Haste module map）。一番搜索资料后发现是说某个版本的 RN 存在缺陷，按照网上的解决方案指定到合适的版本，还是不能解决问题，先提交代码，后期找到解决方案进行修改
@interface TestViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
