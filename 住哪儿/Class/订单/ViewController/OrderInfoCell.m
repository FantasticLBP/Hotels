//
//  OrderInfoCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/8.
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
    [self addSubview:self.orderNumberLabel];
    [self addSubview:self.hotelLabel];
    [self addSubview:self.orderAddressLabel];
    [self addSubview:self.roomTypeLabel];
    [self addSubview:self.roomLabel];
    [self addSubview:self.leavingLabel];
    [self addSubview:self.leavingDetailLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(18);
        make.top.equalTo(self).with.offset(17);
        make.size.mas_offset(CGSizeMake(90, 21));
    }];
    
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderLabel.mas_right).with.offset(5);
        make.right.equalTo(self);
        make.top.equalTo(self.orderLabel);
        make.bottom.equalTo(self.orderLabel);
    }];
    
    [self.hotelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderLabel);
        make.width.mas_equalTo(90);
        make.top.equalTo(self.orderLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(21);
    }];
    
    [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNumberLabel);
        make.right.equalTo(self.orderNumberLabel);
        make.top.equalTo(self.hotelLabel);
        make.bottom.equalTo(self.hotelLabel);
    }];
    
    [self.roomTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelLabel);
        make.top.equalTo(self.hotelLabel.mas_bottom).with.offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(21);
    }];
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderAddressLabel);
        make.right.equalTo(self.orderAddressLabel);
        make.top.equalTo(self.roomTypeLabel);
        make.bottom.equalTo(self.roomTypeLabel);
    }];
    
    
    [self.leavingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomTypeLabel);
        make.top.equalTo(self.roomTypeLabel.mas_bottom).with.offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(21);
    }];
    
    [self.leavingDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomLabel);
        make.right.equalTo(self.roomLabel);
        make.top.equalTo(self.leavingLabel);
        make.bottom.equalTo(self.leavingLabel);
    }];
}

-(void)setOrderNumber:(NSString *)orderNumber{
    _orderNumber = orderNumber;
    if ([ProjectUtil isNotBlank:orderNumber]) {
        self.orderNumberLabel.text = orderNumber;
    }
}

-(void)setRoomType:(NSString *)roomType{
    _roomType = roomType;
    if ([ProjectUtil isNotBlank:roomType]) {
        self.roomLabel.text = roomType;
    }
}

-(void)setHotelName:(NSString *)hotelName{
    _hotelName = hotelName;
    if ([ProjectUtil isNotBlank:hotelName]) {
        self.orderAddressLabel.text = hotelName;
    }
}

-(void)setLivingPeriods:(NSString *)livingPeriods{
    _livingPeriods = livingPeriods;
    if ([ProjectUtil isNotBlank:livingPeriods]) {
        self.leavingDetailLabel.text = livingPeriods;
    }
}

#pragma mark - lazy load
-(UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [UILabel new];
        _orderLabel.text = @"订  单  号：";
        _orderLabel.textColor = [UIColor colorFromHexCode:@"888888"];
        _orderLabel.font = [UIFont systemFontOfSize:14];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _orderLabel;
}

-(UILabel *)hotelLabel{
    if (!_hotelLabel) {
        _hotelLabel = [UILabel new];
        _hotelLabel.text = @"酒店名称：";
        _hotelLabel.textAlignment = NSTextAlignmentLeft;
        _hotelLabel.textColor = [UIColor colorFromHexCode:@"888888"];;
        _hotelLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _hotelLabel;
}

-(UILabel *)roomTypeLabel{
    if (!_roomTypeLabel) {
        _roomTypeLabel = [UILabel new];
        _roomTypeLabel.text = @"房       型：";
        _roomTypeLabel.textAlignment = NSTextAlignmentLeft;
        _roomTypeLabel.textColor = [UIColor colorFromHexCode:@"888888"];;
        _roomTypeLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _roomTypeLabel;
}


-(UILabel *)leavingLabel{
    if (!_leavingLabel) {
        _leavingLabel = [UILabel new];
        _leavingLabel.text = @"入离日期：";
        _leavingLabel.textAlignment = NSTextAlignmentLeft;
        _leavingLabel.textColor = [UIColor colorFromHexCode:@"888888"];;
        _leavingLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _leavingLabel;
}

-(UILabel *)orderNumberLabel{
    if (!_orderNumberLabel) {
        _orderNumberLabel = [UILabel new];
        _orderNumberLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumberLabel.textColor = [UIColor blackColor];
        _orderNumberLabel.font = [UIFont systemFontOfSize:14];
    }
    return _orderNumberLabel;
}

-(UILabel *)roomLabel{
    if (!_roomLabel) {
        _roomLabel = [UILabel new];
        _roomLabel.textAlignment = NSTextAlignmentLeft;
        _roomLabel.textColor = [UIColor blackColor];
        _roomLabel.font = [UIFont systemFontOfSize:14];
    }
    return _roomLabel;
}

-(UILabel *)orderAddressLabel{
    if (!_orderAddressLabel) {
        _orderAddressLabel = [UILabel new];
        _orderAddressLabel.textAlignment = NSTextAlignmentLeft;
        _orderAddressLabel.textColor = [UIColor blackColor];
        _orderAddressLabel.font = [UIFont systemFontOfSize:14];
    }
    return _orderAddressLabel;
}

-(UILabel *)leavingDetailLabel{
    if (!_leavingDetailLabel) {
        _leavingDetailLabel = [UILabel new];
        _leavingDetailLabel.textAlignment = NSTextAlignmentLeft;
        _leavingDetailLabel.textColor = [UIColor blackColor];
        _leavingDetailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _leavingDetailLabel;
}


@end
