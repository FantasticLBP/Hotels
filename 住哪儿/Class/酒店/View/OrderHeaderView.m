

//
//  OrderHeaderView.m
//  住哪儿
//
//  Created by geek on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderHeaderView.h"
@interface OrderHeaderView()
@property (nonatomic, strong) UIImageView *bgImagView;
@property (nonatomic, strong) UILabel *cancelPrincipleLabel;
@property (nonatomic, strong) UIImageView *noticeImageView;
@property (nonatomic, strong) UILabel *noticeLabel;

@end
@implementation OrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];
    [self addSubview:self.bgImagView];
    [self addSubview:self.cancelPrincipleLabel];
    [self addSubview:self.noticeImageView];
    [self addSubview:self.noticeLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(138);
    }];
    
    [self.cancelPrincipleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self.bgImagView.mas_bottom).with.offset(8);
        make.right.equalTo(self);
        make.height.mas_equalTo(21);
    }];
    
    [self.noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelPrincipleLabel.mas_left);
        make.top.equalTo(self.cancelPrincipleLabel.mas_bottom).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeImageView.mas_right).with.offset(7);
        make.top.equalTo(self.noticeImageView.mas_top);
        make.bottom.equalTo(self.noticeImageView.mas_bottom);
        make.width.mas_equalTo(BoundWidth - 37);
    }];
}

#pragma mark - lazy load
-(UIImageView *)bgImagView{
    if (!_bgImagView) {
        _bgImagView = [UIImageView new];
        _bgImagView.image = [UIImage imageNamed:@"Hotel_orderHeader"];
    }
    return _bgImagView;
}

-(UILabel *)cancelPrincipleLabel{
    if (!_cancelPrincipleLabel) {
        _cancelPrincipleLabel = [UILabel new];
        _cancelPrincipleLabel.textAlignment = NSTextAlignmentLeft;
        _cancelPrincipleLabel.font = [UIFont systemFontOfSize:12];
        _cancelPrincipleLabel.textColor = [UIColor blackColor];
        _cancelPrincipleLabel.text = @"取消规则";
    }
    return _cancelPrincipleLabel;
}

-(UIImageView *)noticeImageView{
    if (!_noticeImageView) {
        _noticeImageView = [UIImageView new];
        _noticeImageView.image = [UIImage imageNamed:@"Hotel_order_notice"];
    }
    return _noticeImageView;
}

-(UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [UILabel new];
        _noticeLabel.textColor = [UIColor colorFromHexCode:@"8a8a8a"];
        _noticeLabel.text = @"订单提交后可随时变更或免费取消。";
        _noticeLabel.font = [UIFont systemFontOfSize:12];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _noticeLabel;
}
@end
