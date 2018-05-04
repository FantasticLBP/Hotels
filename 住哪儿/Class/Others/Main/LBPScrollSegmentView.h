//
//  LBPScrollSegmentView.h
//  heletalk-doctor
//
//  Created by 杭城小刘 on 16/8/4.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBPScrollSegmentView;

@protocol LBPScrollSegmentViewDelegate <NSObject>

@optional;
-(void)lbpScrollSegmentView:(LBPScrollSegmentView *)lbpScrollSegmentView didScrolledWIthIndex:(int)index;

-(void)lbpScrollSegmentView:(LBPScrollSegmentView *)lbpScrollSegmentView viewWillAppear:(id)index;

@end

@interface LBPScrollSegmentView : UIView
@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIColor *titleLabelSelectedColor;
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, weak) id<LBPScrollSegmentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<LBPScrollSegmentViewDelegate>)delegate titlesGroup:(NSArray *)titles controllersGroup:(NSArray *)controllers;

- (void)showItemNotice:(NSInteger)itmeIndex hidden:(BOOL)hidden;

-(void)showButtonWithIndex:(NSInteger)index;

@end





