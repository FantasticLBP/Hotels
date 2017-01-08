//
//  OrderInfoCell.m
//  住哪儿
//
//  Created by geek on 2017/1/8.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderInfoCell.h"

@interface OrderInfoCell()
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic, strong) UILabel *leavingLabel;

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *orderAddressLabel;
@property (nonatomic, strong) UILabel *roomLabel;
@property (nonatomic, strong) UILabel *leavingDetailLabel;
@end
@implementation OrderInfoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.orderLabel];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(18);
        make.top.equalTo(self).with.offset(17);
        make.size.mas_offset(CGSizeMake(60, 21));
    }];
    
}

#pragma mark - lazy load
-(UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [UILabel new];
        _orderLabel.text = @"订  单  号";
        _orderLabel.textColor = [UIColor colorFromHexCode:@"888888"];
        _orderLabel.font = [UIFont systemFontOfSize:18];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _orderLabel;
}


@end
