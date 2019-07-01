
//
//  HotelImageCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelImageCell.h"
#import "SDCycleScrollView.h"

@interface HotelImageCell()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UIView *boundaryView;

@property (nonatomic, strong) UIImageView *locateImageView;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIImageView *watchImageView;
@property (nonatomic, strong) UIImageView *albumsImageView;
@property (nonatomic, strong) UILabel *albumsCountLabel;
@end

@implementation HotelImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.advertiseView];
    [self addSubview:self.hotelLabel];

    [self addSubview:self.bottomView];
    [self addSubview:self.boundaryView];
    
    [self addSubview:self.locateImageView];
    [self addSubview:self.locationLabel];
    [self addSubview:self.watchImageView];
    [self addSubview:self.albumsImageView];
    [self addSubview:self.albumsCountLabel];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.advertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(249);
    }];
    
    [self.hotelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.advertiseView).with.offset(16);
        make.right.equalTo(self.advertiseView);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(198);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.mas_equalTo(self.advertiseView.mas_bottom);
        make.height.mas_equalTo(54);
    }];
    
    [self.boundaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.mas_equalTo(self.bottomView.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.locateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.top.equalTo(self.bottomView).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locateImageView.mas_right).with.offset(10);
        make.right.equalTo(self.watchImageView).with.offset(-10);
        make.top.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView);
    }];
    
    [self.watchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-18);
        make.top.equalTo(self.locateImageView);
        make.size.mas_equalTo(CGSizeMake(10, 18));
    }];
    
    [self.albumsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.advertiseView).with.offset(-28-16);
        make.bottom.equalTo(self.advertiseView).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(21, 18));
    }];
    
    [self.albumsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.albumsImageView.mas_right).with.offset(3);
        make.top.equalTo(self.albumsImageView.mas_top);
        make.bottom.equalTo(self.albumsImageView.mas_bottom);
        make.width.mas_equalTo(BoundWidth-self.albumsImageView.frame.origin.x - self.albumsImageView.frame.size.width);
    }];
}

-(void)setImages:(NSMutableArray *)images{
    _images = images;
    if (images.count == 0) {
        return;
    }
    self.advertiseView.imageURLStringsGroup = images;
    self.albumsCountLabel.text = [NSString stringWithFormat:@"%zd",images.count];
}

-(void)setHotelModel:(HotelsModel *)hotelModel{
    _hotelModel = hotelModel;
    if (hotelModel) {
        self.locationLabel.text = hotelModel.address;
        self.hotelLabel.text = hotelModel.hotelName;
    }
}

#pragma mark - button method
-(void)watchAlbums{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelImageCell:didOperateHotelWithType:)]) {
        [self.delegate hotelImageCell:self didOperateHotelWithType:Watch_Hotel_DetailImage];
    }
}

-(void)watchMap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelImageCell:didOperateHotelWithType:)]) {
        [self.delegate hotelImageCell:self didOperateHotelWithType:Watch_Hotel_Map];
    }
}
#pragma mark - lazy load
-(SDCycleScrollView *)advertiseView{
    if (!_advertiseView) {
        SDCycleScrollView *adview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adview.pageControlAliment = SDCycleScrollViewPageContolAlimentLeft;
        adview.currentPageDotColor = GlobalMainColor;
        UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchAlbums)];
        signalTap.cancelsTouchesInView = YES;
        [adview addGestureRecognizer:signalTap];
        _advertiseView = adview;
    }
    return _advertiseView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchMap)];
        signalTap.cancelsTouchesInView = YES;
        [_bottomView addGestureRecognizer:signalTap];
    }
    return _bottomView;
}

-(UILabel *)hotelLabel{
    if (!_hotelLabel) {
        _hotelLabel = [UILabel new];
        _hotelLabel.textAlignment = NSTextAlignmentLeft;
        _hotelLabel.textColor = [UIColor whiteColor];
        _hotelLabel.font = [UIFont systemFontOfSize:18.0];
        _hotelLabel.text = @"杭州艺联君厅酒店";
    }
    return _hotelLabel;
}

-(UIView *)boundaryView{
    if (!_boundaryView) {
        _boundaryView = [UIView new];
        _boundaryView.backgroundColor = CollectionViewBackgroundColor;
    }
    return _boundaryView;
}

-(UIImageView *)locateImageView{
    if (!_locateImageView) {
        _locateImageView = [UIImageView new];
        _locateImageView.image = [UIImage imageNamed:@"Hotel_location"];
    }
    return _locateImageView;
}

-(UIImageView *)watchImageView{
    if (!_watchImageView) {
        _watchImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _watchImageView.image = [UIImage imageNamed:@"Hotel_watch"];
    }
    return _watchImageView;
}

-(UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel = [UILabel new];
        _locationLabel.font = [UIFont systemFontOfSize:15];
        _locationLabel.textColor = [UIColor colorFromHexCode:@"858585"];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _locationLabel;
}

-(UIImageView *)albumsImageView{
    if (!_albumsImageView) {
        _albumsImageView = [UIImageView new];
        _albumsImageView.image = [UIImage imageNamed:@"Hotel_detail_image"];
    }
    return _albumsImageView;
}

-(UILabel *)albumsCountLabel{
    if (!_albumsCountLabel) {
        _albumsCountLabel = [UILabel new];
        _albumsCountLabel.font = [UIFont systemFontOfSize:13];
        _albumsCountLabel.textColor = [UIColor whiteColor];
        _albumsCountLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _albumsCountLabel;
}
@end
