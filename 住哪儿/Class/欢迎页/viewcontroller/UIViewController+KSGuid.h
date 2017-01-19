//
//  UIViewController+KSGuid.h
//  test
//
//  Created by kong on 16/7/21.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KSGuid)<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

//*实现引导页的控制器，外部不用调用即可实现GuidView,可以修改下面的图片*/

@end

/*这里是要展示的图片，修改即可,当然不止三个  1242 * 2208的分辨率最佳,如果在小屏手机上显示不全，最好要求UI重新设计图片*/

#define ImageArray @[@"IMG_1",@"IMG_2",@"IMG_3",@"IMG_4",@"IMG_5"]

/** pageIndicatorTintColor*/
#define pageTintColor [UIColor grayColor];
/** currentPageIndicatorTintColor*/
#define currentTintColor [UIColor colorFromHexCode:@"803ec5"];


/*
如果要修改立即体验按钮的样式
重新- (UIButton*)removeBtn方法即可
*/
