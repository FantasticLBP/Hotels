//
//  LBPScrollSegmentView.h
//  heletalk-doctor
//
//  Created by geek on 16/8/4.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LBPcrollSegmentViewDelegate <NSObject>
@end

@interface LBPScrollSegmentView : UIView
@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIColor *titleLabelSelectedColor;
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, weak) id<LBPcrollSegmentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<LBPcrollSegmentViewDelegate>)delegate titlesGroup:(NSArray *)titles controllersGroup:(NSArray *)controllers;

- (void)showItemNotice:(NSInteger)itmeIndex hidden:(BOOL)hidden;

-(void)showButtonWithIndex:(NSInteger)index;

@end





