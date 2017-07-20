
//
//  HotelKindCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelKindCell.h"
@interface HotelKindCell()
@property (nonatomic, strong) UIImageView *hotelImageView;
@property (nonatomic, strong) UILabel *hotelTypeLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *specialLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation HotelKindCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.hotelImageView];
    [self addSubview:self.hotelTypeLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.specialLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.line];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.hotelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(72, 66));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.right.equalTo(self).with.offset(-9-12);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrowImageView.mas_left).with.offset(-3);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(21);
    }];
    
    [self.hotelTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.left.equalTo(self.hotelImageView.mas_right).with.offset(5);
        make.top.mas_equalTo(21);
        make.right.mas_equalTo(self);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(1);
    }];

    [self.specialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotelTypeLabel);
        make.top.equalTo(self.hotelTypeLabel.mas_bottom).with.offset(2);
        make.height.mas_equalTo(21);
        make.right.equalTo(self.priceLabel.mas_left);
    }];
}


-(void)setRoomModel:(RoomModel *)roomModel{
    _roomModel = roomModel;
    if (roomModel) {
        NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,roomModel.image1];
        [self.hotelImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Hotel_placeholder"]];
        self.hotelTypeLabel.text = [ProjectUtil isNotBlank:roomModel.type]?roomModel.type:@"";
        self.specialLabel.text = [NSString stringWithFormat:@"%zd平米 %@ %@ 剩余%zd间",roomModel.square,roomModel.bedScale,roomModel.hasWindow==1?@"有窗":@"无窗",roomModel.count];
        self.priceLabel.text = [NSString stringWithFormat:@"%zd",roomModel.znecancelPrice];
    }
}
#pragma mark - lazy load
-(UIImageView *)hotelImageView{
    if (!_hotelImageView) {
        _hotelImageView = [UIImageView new];
    }
    return _hotelImageView;
}

-(UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"Hotel_watch"];
    }
    return _arrowImageView;
}

-(UILabel *)specialLabel{
    if (!_specialLabel) {
        _specialLabel = [UILabel new];
        _specialLabel.textColor = [UIColor colorFromHexCode:@"bcbcbc"];
        _specialLabel.textAlignment = NSTextAlignmentLeft;
        _specialLabel.font = [UIFont systemFontOfSize:13];
    }
    return _specialLabel;
}

-(UILabel *)hotelTypeLabel{
    if (!_hotelTypeLabel) {
        _hotelTypeLabel = [UILabel new];
        _hotelTypeLabel.textColor = [UIColor blackColor];
        _hotelTypeLabel.textAlignment = NSTextAlignmentLeft;
        _hotelTypeLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _hotelTypeLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _priceLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorFromHexCode:@"ebebeb"];
    }
    return _line;
}

@end
