
//
//  HotelBaseConditionCell.m
//  住哪儿
//
//  Created by geek on 2016/12/26.
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
    
    [self addSubview:self.wifiImageView];
    [self addSubview:self.wifiLabel];
    [self addSubview:self.parkLabel];
    [self addSubview:self.parkImageView];
    [self addSubview:self.packageLabel];
    [self addSubview:self.packageImageView];
    [self addSubview:self.meetingLabel];
    [self addSubview:self.meetingImageView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    
}

-(void)setBuildTime:(NSString *)buildTime{
    _buildTime = buildTime;
    
    
}

#pragma mark - lazy load
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.text = @"酒店详情";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = PlaceHolderColor;
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
        _packageImageView.image = [UIImage imageNamed:@"Hotel_meeting"];
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
        
    }
}
@end
