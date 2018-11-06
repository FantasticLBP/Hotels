
//
//  OrderFillFooterView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderFillFooterView.h"

@interface OrderFillFooterView()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UIView *line;

@end
@implementation OrderFillFooterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line];
    [self addSubview:self.priceLabel];
    [self addSubview:self.payButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(self);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(1);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(100);
    }];

    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(4);
        make.right.equalTo(self).with.offset(-10);
        make.bottom.equalTo(self).with.offset(-3);
        make.width.mas_equalTo(BoundWidth/2);
    }];
}

-(void)setPrice:(NSString *)price{
    _price = price;
    if ([ProjectUtil isNotBlank:price]) {
        self.priceLabel.text = [@"¥" stringByAppendingString:price];
    }
}
    
-(void)commitOrder{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderFillFooterView:didClickPayButton:)]) {
        [self.delegate orderFillFooterView:self didClickPayButton:YES];
    }
}

#pragma mark - private method
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorFromHexCode:@"c8c8c8"];
    }
    return  _line;
}

-(UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.backgroundColor = [UIColor redColor];
        _payButton.layer.cornerRadius = 2;
        _payButton.layer.masksToBounds = YES;
        [_payButton setTitle:@"去支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(commitOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}
@end
