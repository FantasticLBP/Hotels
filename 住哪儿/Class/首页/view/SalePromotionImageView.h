//
//  SalePromotionImageView.h
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SalePromotionImageViewLocationType){
    SalePromotionImageViewLocationType_Left,                    //左边
    SalePromotionImageViewLocationType_Center,                  //中间
    SalePromotionImageViewLocationType_RIght                    //右边
};


@class SalePromotionImageView;
@protocol SalePromotionImageViewDelegate <NSObject>

@optional
-(void)salePromotionImageView:(SalePromotionImageView *)salePromotionImageView didClickAtPromotionView:(NSString *)flag;

@end

@interface SalePromotionImageView : UIImageView

@property (nonatomic, strong) NSString *defaultImageName;                              /**<本地图片名称*/
@property (nonatomic, strong) NSString *imageUrl;                               /**<通过网络加载图片的url*/
@property (nonatomic, assign) SalePromotionImageViewLocationType locationType;  /**<图片在屏幕上的相对位置：左边、中间、右边*/
@property (nonatomic, weak) id<SalePromotionImageViewDelegate> delegate;        /**<单击事件代理*/
@property (nonatomic, copy) void(^SalePromotionImageViewBlock)(NSString *url);

/**
 *  默认初始化方法
 *
 *  @param frame 大小
 *
 *  @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame;

/**
 *  通过图片url初始化
 *
 * @param frame 界面Frame
 *
 * @param urlString 网络图片url
 *
 * @param imageName 默认图片名称
 */
-(instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString placeHolder:(NSString *)imageName;

/**
 *  在某个界面上显示
 *
 *
 *  @param viewController 父控制器
 */
-(void)showInView:(UIViewController *)viewController;

@end
