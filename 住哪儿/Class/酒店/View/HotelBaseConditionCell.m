
//
//  HotelBaseConditionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelBaseConditionCell.h"

@interface HotelBaseConditionCell()

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *decorateLabel;
@property (nonatomic, strong) UIImageView *wifiImageView;
@property (nonatomic, strong) UIImageView *parkImageView;
@property (nonatomic, strong) UIImageView *packageImageView;
@property (nonatomic, strong) UIImageView *meetingImageView;
@property (nonatomic, strong) UILabel *wifiLabel;
@property (nonatomic, strong) UILabel *parkLabel;
@property (nonatomic, strong) UILabel *packageLabel;
@property (nonatomic, strong) UILabel *meetingLabel;
@property (nonatomic, strong) UIView *bottomView;
@end
@implementation HotelBaseConditionCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.detailLabel];
    [self addSubview:self.startLabel];
    [self addSubview:self.decorateLabel];
    [self addSubview:self.wifiImageView];
    [self addSubview:self.wifiLabel];
    [self addSubview:self.parkLabel];
    [self addSubview:self.parkImageView];
    [self addSubview:self.packageLabel];
    [self addSubview:self.packageImageView];
    [self addSubview:self.meetingLabel];
    [self addSubview:self.meetingImageView];
    [self addSubview:self.bottomView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_equalTo(21);
    }];
    
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.detailLabel).with.offset(3);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(self.frame.size.width/2);
    }];
    
    
    [self.decorateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startLabel.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self.startLabel);
        make.top.equalTo(self.startLabel);
    }];
    
    [self.wifiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(44);
        make.top.equalTo(self.startLabel.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake((BoundWidth-220)/4, 23));
    }];
    
    [self.wifiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wifiImageView);
        make.right.equalTo(self.wifiImageView);
        make.top.equalTo(self.wifiImageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [self.parkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wifiImageView.mas_right).with.offset(44);
        make.top.equalTo(self.wifiImageView);
        make.size.equalTo(self.wifiImageView);
    }];
    
    [self.parkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.parkImageView);
        make.right.equalTo(self.parkImageView);
        make.top.equalTo(self.parkImageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.packageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.parkImageView.mas_right).with.offset(44);
        make.top.equalTo(self.parkImageView);
        make.size.equalTo(self.parkImageView);
    }];
    [self.packageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.packageImageView);
        make.right.equalTo(self.packageImageView);
        make.top.equalTo(self.packageImageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [self.meetingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.packageImageView.mas_right).with.offset(44);
        make.top.equalTo(self.packageImageView);
        make.size.equalTo(self.packageImageView);
    }];
    [self.meetingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.meetingImageView);
        make.right.equalTo(self.meetingImageView);
        make.top.equalTo(self.meetingImageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(10);
    }];
}


-(void)setModel:(HotelsModel *)model{
    _model = model;
    if (model) {
        self.startLabel.text = [NSString stringWithFormat:@"开业时间：%@",model.startTime];
        self.decorateLabel.text = [NSString stringWithFormat:@"开业时间：%@",model.decorateTime];
        if (!model.hasWifi) {
            _wifiImageView.image = [UIImage imageNamed:@"Hotel_wifiLess"];
        }
        if (!model.hasParking) {
            _parkImageView.image = [UIImage imageNamed:@"Hotel_parkingLess"];
        }
        if (!model.hasPackage) {
            _packageImageView.image = [UIImage imageNamed:@"Hotel_packageLess"];
        }
        if (!model.hasMeetingRoom) {
            _meetingImageView.image = [UIImage imageNamed:@"Hotel_meetingLess"];
        }
        
    }
}

#pragma mark - lazy load
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.text = @"酒店详情";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = [UIColor colorFromHexCode:@"4f9fff"];
        _detailLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailLabel;
}

-(UIImageView *)wifiImageView{
    if (!_wifiImageView) {
        _wifiImageView = [UIImageView new];
        _wifiImageView.image = [UIImage imageNamed:@"Hotel_wifi"];
    }
    return _wifiImageView;
}

-(UIImageView *)parkImageView{
    if (!_parkImageView) {
        _parkImageView = [UIImageView new];
        _parkImageView.image = [UIImage imageNamed:@"Hotel_parking"];
    }
    return _parkImageView;
}

-(UIImageView *)packageImageView{
    if (!_packageImageView) {
        _packageImageView = [UIImageView new];
        _packageImageView.image = [UIImage imageNamed:@"Hotel_package"];
    }
    return _packageImageView;
}

-(UIImageView *)meetingImageView{
    if (!_meetingImageView) {
        _meetingImageView = [UIImageView new];
        _meetingImageView.image = [UIImage imageNamed:@"Hotel_meeting"];
    }
    return _meetingImageView;
}

-(UILabel *)wifiLabel{
    if (!_wifiLabel) {
        _wifiLabel = [UILabel new];
        _wifiLabel.textAlignment = NSTextAlignmentCenter;
        _wifiLabel.font = [UIFont systemFontOfSize:11];
        _wifiLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _wifiLabel.text = @"无线上网";
    }
    return  _wifiLabel;
}

-(UILabel *)parkLabel{
    if (!_parkLabel) {
        _parkLabel = [UILabel new];
        _parkLabel.textAlignment = NSTextAlignmentCenter;
        _parkLabel.font = [UIFont systemFontOfSize:11];
        _parkLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _parkLabel.text = @"包含停车";
    }
    return  _parkLabel;
}

-(UILabel *)packageLabel{
    if (!_packageLabel) {
        _packageLabel = [UILabel new];
        _packageLabel.textAlignment = NSTextAlignmentCenter;
        _packageLabel.font = [UIFont systemFontOfSize:11];
        _packageLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _packageLabel.text = @"行李寄存";
    }
    return  _packageLabel;
}

-(UILabel *)meetingLabel{
    if (!_meetingLabel) {
        _meetingLabel = [UILabel new];
        _meetingLabel.textAlignment = NSTextAlignmentCenter;
        _meetingLabel.font = [UIFont systemFontOfSize:11];
        _meetingLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _meetingLabel.text = @"会议室";
    }
    return  _meetingLabel;
}

-(UILabel *)startLabel{
    if (!_startLabel) {
        _startLabel = [UILabel new];
        _startLabel.textAlignment = NSTextAlignmentCenter;
        _startLabel.font = [UIFont systemFontOfSize:14];
        _startLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _startLabel.text = @"开业时间：2007年04年01日";
    }
    return  _startLabel;
}


-(UILabel *)decorateLabel{
    if (!_decorateLabel) {
        _decorateLabel = [UILabel new];
        _decorateLabel.textAlignment = NSTextAlignmentCenter;
        _decorateLabel.font = [UIFont systemFontOfSize:14];
        _decorateLabel.textColor = [UIColor colorFromHexCode:@"868686"];
        _decorateLabel.text = @"装修时间：2007年03年01日";
    }
    return  _decorateLabel;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];
    }
    return _bottomView;
}

@end
