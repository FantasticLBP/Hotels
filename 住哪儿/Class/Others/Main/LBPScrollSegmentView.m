
//
//  LBPScrollSegmentView.m
//  heletalk-doctor
//
//  Created by 杭城小刘 on 16/8/4.
//  Copyright © 2016年 heletech. All rights reserved.
//
#import "LBPScrollSegmentView.h"

@interface LBPScrollSegmentView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation LBPScrollSegmentView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<LBPScrollSegmentViewDelegate>)delegate titlesGroup:(NSArray *)titles controllersGroup:(NSArray *)controllers
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        self.delegate = delegate;
        self.titleArray = titles;
        self.controllers = controllers;
        [self addSubview:self.headView];
        [self addSubview:self.selectView];
        [self addSubview:self.scrollView];
        [self btnClick:self.items.firstObject];
    }
    return self;
}

- (void)reloadView {
    if (_headView) {
        [_headView removeFromSuperview];
        _items = nil;
        _headView = nil;
        [self addSubview:self.headView];
    }
    if (_selectView) {
        [_selectView removeFromSuperview];
        _selectView = nil;
        [self addSubview:self.selectView];
    }
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        [self addSubview:self.scrollView];
        [self btnClick:self.items.firstObject];
    }
    
    
}


- (void)initialization {
    _titleLabelTextColor = [UIColor blackColor];
    _titleLabelSelectedColor = GlobalMainColor;
    _titleLabelTextFont = [UIFont systemFontOfSize:13];
    _titleLabelBackgroundColor = GlobalMainColor;
    _titleLabelHeight = 41;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int itemIndex = (scrollView.contentOffset.x + self.frame.size.width * 0.5) / self.frame.size.width;
    int index = itemIndex % self.titleArray.count;
    int scrolledIndex = (@(index) == nil)?0:index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lbpScrollSegmentView:didScrolledWIthIndex:)]) {
        [self.delegate lbpScrollSegmentView:self didScrolledWIthIndex:scrolledIndex];
    }
    
    UIButton *selectbtn = [self.items objectAtIndex:index];
    
    for (UIButton *btn in self.items) {
        [btn setTitleColor:self.titleLabelTextColor forState:UIControlStateNormal];
    }
    [selectbtn setTitleColor:self.titleLabelSelectedColor forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    self.selectView.center = CGPointMake(selectbtn.center.x, self.selectView.center.y);
    [UIView commitAnimations];
}

- (void)btnClick:(UIButton *)sender {
    for (UIButton *btn in self.items) {
        [btn setTitleColor:self.titleLabelTextColor forState:UIControlStateNormal];
    }
    [sender setTitleColor:self.titleLabelSelectedColor forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    self.selectView.center = CGPointMake(sender.center.x, self.selectView.center.y);
    [self.scrollView setContentOffset:CGPointMake([self.items indexOfObject:sender] * self.frame.size.width, 0.0f) animated:NO];
    [UIView commitAnimations];
}


-(void)showButtonWithIndex:(NSInteger)index{
    UIButton *button = (UIButton *)self.items[index];
    [button setTitleColor:self.titleLabelTextColor forState:UIControlStateNormal];
    [button setTitleColor:self.titleLabelSelectedColor forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    self.selectView.center = CGPointMake(button.center.x, self.selectView.center.y);
    [self.scrollView setContentOffset:CGPointMake([self.items indexOfObject:button] * self.frame.size.width, 0.0f) animated:NO];
    [UIView commitAnimations];
}

- (void)showItemNotice:(NSInteger)itmeIndex hidden:(BOOL)hidden {
    if (itmeIndex>=self.items.count) {
        return;
    }else {
        UIButton *btn = [self.items objectAtIndex:itmeIndex];
        UIImageView *remindView = btn.subviews.lastObject;
        remindView.hidden = hidden;
    }
}

#pragma mark - Setters && getters

- (void)setTitleLabelHeight:(CGFloat)titleLabelHeight {
    _titleLabelHeight = titleLabelHeight;
    [self reloadView];
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont {
    _titleLabelTextFont = titleLabelTextFont;
    [self reloadView];
}

- (void)setTitleLabelSelectedColor:(UIColor *)titleLabelSelectedColor {
    _titleLabelSelectedColor = titleLabelSelectedColor;
    [self reloadView];
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self reloadView];
}

- (void)setControllers:(NSArray *)controllers {
    _controllers = controllers;
    [self reloadView];
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.titleLabelHeight)];
        UIView *titleBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabelHeight-1, BoundWidth, 1)];
        titleBottomView.backgroundColor = self.titleLabelBackgroundColor;
        [_headView addSubview:titleBottomView];
        
        for (UIButton *btn in self.items) {
            [_headView addSubview:btn];
        }
        [_headView addSubview:self.selectView];
    }
    return _headView;
}

- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabelHeight - 4, self.frame.size.width/self.titleArray.count, 3)];
        _selectView.backgroundColor = self.titleLabelSelectedColor;
    }
    return _selectView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleLabelHeight, BoundWidth, self.frame.size.height-self.titleLabelHeight)];
        _scrollView.contentSize = CGSizeMake(self.frame.size.width*self.controllers.count, 0.0f);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        for (int i = 0; i < self.controllers.count; i++) {
            UIViewController *vc = [self.controllers objectAtIndex:i];
            vc.view.frame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, _scrollView.bounds.size.height);
            [_scrollView addSubview:vc.view];
            UIViewController *pvc = (UIViewController *)self.delegate;
            [pvc addChildViewController:vc];
        }
    }
    return _scrollView;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*self.frame.size.width/self.titleArray.count, 0, self.frame.size.width/self.titleArray.count, self.titleLabelHeight-1);
            btn.titleLabel.font = self.titleLabelTextFont;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:[self.titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *remindView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_remind"]];
            remindView.frame = CGRectMake(self.frame.size.width/self.titleArray.count -38, 10, 7, 7);
            remindView.hidden = YES;
            
            [btn addSubview:remindView];
            [_items addObject:btn];
        }
    }
    return _items;
}
@end

