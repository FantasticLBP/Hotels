

//
//  OrderHeaderView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderHeaderView.h"
@interface OrderHeaderView()
@property (nonatomic, strong) UIImageView *bgImagView;
@property (nonatomic, strong) UILabel *cancelPrincipleLabel;
@property (nonatomic, strong) UIImageView *noticeImageView;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *hotelNameLabel;
@property (nonatomic, strong) UILabel *checkinLabel;
@property (nonatomic, strong) UILabel *checkoutLabel;
@property (nonatomic, strong) UILabel *checkinTimeLabel;
@property (nonatomic, strong) UILabel *checkoutTimeLabel;
@property (nonatomic, strong) UILabel *totalNightLabel;
@property (nonatomic, strong) UILabel *roomDetailLabel;
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
    [self addSubview:self.noticeImageView];
    [self addSubview:self.noticeLabel];
    [self addSubview:self.hotelNameLabel];
    [self addSubview:self.cancelPrincipleLabel];
    [self addSubview:self.checkinLabel];
    [self addSubview:self.checkoutLabel];
    [self addSubview:self.checkinTimeLabel];
    [self addSubview:self.checkoutTimeLabel];
    [self addSubview:self.totalNightLabel];
    [self addSubview:self.roomDetailLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(138);
    }];
    
    
    if (self.type == OrderHeaderType_Pay) {
        [self.cancelPrincipleLabel removeFromSuperview];
        [self.noticeImageView removeFromSuperview];
        [self.noticeLabel removeFromSuperview];
    }
    
    if (self.type ==  OrderHeaderType_Order) {
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
    
    
    [self.hotelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImagView).with.offset(15);
        make.right.equalTo(self.bgImagView).with.offset(-15);
        make.top.equalTo(self.bgImagView).with.offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [self.checkinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelNameLabel.mas_left);
        make.top.equalTo(self.bgImagView).with.offset(50);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(40);
    }];
    
    [self.checkinTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkinLabel.mas_right).with.offset(9);
        make.top.equalTo(self.checkinLabel.mas_top);
        make.bottom.equalTo(self.checkinLabel.mas_bottom);
        make.width.mas_equalTo(120);
    }];
    
    [self.checkoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkinTimeLabel.mas_right).with.offset(6);
        make.top.equalTo(self.checkinTimeLabel.mas_top);
        make.bottom.equalTo(self.checkinTimeLabel.mas_bottom);
        make.width.mas_equalTo(34);
    }];
    
    [self.checkoutTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkoutLabel.mas_right).with.offset(9);
        make.top.equalTo(self.checkoutLabel.mas_top);
        make.bottom.equalTo(self.checkoutLabel.mas_bottom);
        make.width.mas_equalTo(120);
    }];
    
    [self.totalNightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkoutTimeLabel.mas_right).with.offset(9);
        make.top.equalTo(self.checkoutTimeLabel.mas_top);
        make.bottom.equalTo(self.checkoutTimeLabel.mas_bottom);
        make.right.equalTo(self);
    }];
    
    [self.roomDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkinLabel);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.checkinLabel.mas_bottom);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - setter
-(void)setHotelName:(NSString *)hotelName{
    _hotelName = hotelName;
    if ([ProjectUtil isNotBlank:hotelName]) {
        self.hotelNameLabel.text = hotelName;
    }
}

-(void)setChechinTime:(NSString *)chechinTime{
    _chechinTime = chechinTime;
    if ([ProjectUtil isNotBlank:chechinTime]) {
        self.checkinTimeLabel.text = chechinTime;
    }
}

-(void)setCheckoutTime:(NSString *)checkoutTime{
    _checkoutTime = checkoutTime;
    if ([ProjectUtil isNotBlank:checkoutTime]) {
        self.checkoutTimeLabel.text = checkoutTime;
    }
}

-(void)setTotalNight:(NSString *)totalNight{
    _totalNight = totalNight;
    if ([ProjectUtil isNotBlank:totalNight]) {
        self.totalNightLabel.text = totalNight;
    }
}

-(void)setRoomDetail:(NSString *)roomDetail{
    _roomDetail = roomDetail;
    if ([ProjectUtil isNotBlank:roomDetail]) {
        self.roomDetailLabel.text = roomDetail;
    }
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

-(UILabel *)hotelNameLabel{
    if (!_hotelNameLabel) {
        _hotelNameLabel = [UILabel new];
        _hotelNameLabel.textAlignment = NSTextAlignmentLeft;
        _hotelNameLabel.font = [UIFont systemFontOfSize:16];
        _hotelNameLabel.textColor = [UIColor blackColor];
    }
    return _hotelNameLabel;
}

-(UILabel *)checkinLabel{
    if (!_checkinLabel) {
        _checkinLabel = [UILabel new];
        _checkinLabel.text = @"入住";
        _checkinLabel.textColor = [UIColor colorFromHexCode:@"c2c2c2"];
        _checkinLabel.font = [UIFont systemFontOfSize:16];
        _checkinLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _checkinLabel;
}

-(UILabel *)checkoutLabel{
    if (!_checkoutLabel) {
        _checkoutLabel = [UILabel new];
        _checkoutLabel.text = @"离店";
        _checkoutLabel.textColor = [UIColor colorFromHexCode:@"c2c2c2"];
        _checkoutLabel.font = [UIFont systemFontOfSize:16];
        _checkoutLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _checkoutLabel;
}

-(UILabel *)checkinTimeLabel{
    if (!_checkinTimeLabel) {
        _checkinTimeLabel = [UILabel new];
        _checkinTimeLabel.textColor = [UIColor blackColor];
        _checkinTimeLabel.font = [UIFont systemFontOfSize:16];
        _checkinTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _checkinTimeLabel;
}

-(UILabel *)checkoutTimeLabel{
    if (!_checkoutTimeLabel) {
        _checkoutTimeLabel = [UILabel new];
        _checkoutTimeLabel.textColor = [UIColor blackColor];
        _checkoutTimeLabel.font = [UIFont systemFontOfSize:16];
        _checkoutTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _checkoutTimeLabel;
}

-(UILabel *)totalNightLabel{
    if (!_totalNightLabel) {
        _totalNightLabel = [UILabel new];
        _totalNightLabel.font = [UIFont systemFontOfSize:16];
        _totalNightLabel.textColor = [UIColor blackColor];
        _totalNightLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _totalNightLabel;
}

-(UILabel *)roomDetailLabel{
    if (!_roomDetailLabel) {
        _roomDetailLabel = [UILabel new];
        _roomDetailLabel.textColor = [UIColor blackColor];
        _roomDetailLabel.font = [UIFont systemFontOfSize:16];
        _roomDetailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _roomDetailLabel;
}
@end
