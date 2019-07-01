

//
//  RoomInfoHeaderView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "RoomInfoHeaderView.h"
#import "RoomBaseInfoView.h"

#define FindDownImageWIdth 16


@interface RoomInfoHeaderView()
@property (nonatomic, strong) UIImageView *roomImage;
@property (nonatomic, strong) UILabel *roomLabel;
@property (nonatomic, strong) UIButton *watchButton;
@property (nonatomic, strong) UILabel *otherLabel;
@property (nonatomic, strong) UILabel *otherInfoLabel;
@end

@implementation RoomInfoHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - private method
-(void)setupUI{
    self.backgroundColor = CollectionViewBackgroundColor;
    [self addSubview:self.roomImage];
    [self addSubview:self.roomLabel];
    [self addSubview:self.watchButton];
    
    RoomBaseInfoView *view1 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(0, 70, BoundWidth/3, 25)];
    [view1 initViewWithImageName:@"Hotel_hasWindow" andLabelText:@"有窗"];
   
    
     RoomBaseInfoView *view2 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(BoundWidth/3, 70, BoundWidth/3, 25)];
    [view2 initViewWithImageName:@"Hotel_hasWifi" andLabelText:@"无线有线"];

    
     RoomBaseInfoView *view3 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(BoundWidth*2/3, 70, BoundWidth/3, 25)];
    [view3 initViewWithImageName:@"Hotel_hasStairs" andLabelText:@"1-2层"];

     RoomBaseInfoView *view4 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(0, 100, BoundWidth/3, 25)];
    [view4 initViewWithImageName:@"Hotel_hasSquare" andLabelText:@"40平米"];


     RoomBaseInfoView *view5 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(BoundWidth/3, 100, BoundWidth/3, 25)];
    [view5 initViewWithImageName:@"Hotel_hasDoubleBed" andLabelText:@"大／双床"];

     RoomBaseInfoView *view6 = [[RoomBaseInfoView alloc] initWithFrame:CGRectMake(BoundWidth*2/3, 100, BoundWidth/3, 25)];
    [view6 initViewWithImageName:@"Hotel_hasDoublePerson" andLabelText:@"可入住2人"];

     [self addSubview:view1];
     [self addSubview:view2];
     [self addSubview:view3];
     [self addSubview:view4];
     [self addSubview:view5];
     [self addSubview:view6];
    [self addSubview:self.otherLabel];
    [self addSubview:self.otherInfoLabel];
}

-(void)watchMoreRoomInfo{
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomInfoHeaderView:didOperateWithTag:)]) {
        [self.delegate roomInfoHeaderView:self didOperateWithTag:RoomOperationType_MoreInfo];
    }
}

-(void)watchMoreImage{
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomInfoHeaderView:didOperateWithTag:)]) {
        [self.delegate roomInfoHeaderView:self didOperateWithTag:RoomOperationType_MorePhoto];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect freme = self.watchButton.frame;
        freme.origin.y = self.frame.size.height - 40;
        self.watchButton.frame = freme;
    } completion:^(BOOL finished) {
    
    }];
    
    self.otherLabel.frame = CGRectMake(10, 145, 50, 21);
    self.otherInfoLabel.frame = CGRectMake(72,  145,BoundWidth -80, 21);
    if (self.frame.size.height == 198) {
        [self.watchButton setImage:[UIImage imageNamed:@"Hotel_moreInfo_up"] forState:UIControlStateNormal];
    }else{
         [self.watchButton setImage:[UIImage imageNamed:@"Hotel_moreInfo_down"] forState:UIControlStateNormal];
    }
}


#pragma mark - setter
-(void)setRoomModel:(RoomModel *)roomModel{
    _roomModel = roomModel;
    self.roomLabel.text = roomModel.type;
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,roomModel.image1];
    [self.roomImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Hotel_placeholder"]];
    self.otherInfoLabel.text = roomModel.otherInfo;
    
    
    /**
     * 根据房屋信息跟新UI
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[RoomBaseInfoView class]]) {
            
        }
    }
     */
}

#pragma mark - lazy load
-(UIImageView *)roomImage{
    if (!_roomImage) {
        _roomImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
        _roomImage.layer.cornerRadius = 5.0f;
        _roomImage.layer.masksToBounds = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchMoreImage)];
        tap.cancelsTouchesInView = YES;
        _roomImage.userInteractionEnabled = YES;
        [_roomImage addGestureRecognizer:tap];
    }
    return _roomImage;
}

-(UILabel *)roomLabel{
    if (!_roomLabel) {
        _roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth/2-50, 10, 100, 21)];
        _roomLabel.textAlignment = NSTextAlignmentCenter;
        _roomLabel.font = [UIFont systemFontOfSize:15];
        _roomLabel.textColor = [UIColor blackColor];
    }
    return _roomLabel;
}

-(UIButton *)watchButton{
    if (!_watchButton) {
        _watchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [UIImage imageNamed:@"Hotel_moreInfo_down"];
        [_watchButton setImage:buttonImage forState:UIControlStateNormal];
        [_watchButton setTitle:@"更多房型信息" forState:UIControlStateNormal];
        _watchButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_watchButton setTitleColor:[UIColor colorFromHexCode:@"4499ff"] forState:UIControlStateNormal];
        [_watchButton setImageEdgeInsets:UIEdgeInsetsMake(0, [ProjectUtil measureLabelWidth:@"更多房型信息" withFontSize:11], 0,0)];
        [_watchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -FindDownImageWIdth, 0, FindDownImageWIdth)];
        [_watchButton addTarget:self action:@selector(watchMoreRoomInfo) forControlEvents:UIControlEventTouchUpInside];
        CGSize buttonTitleLabelSize = [@"更多房型信息" sizeWithAttributes:@{NSFontAttributeName:_watchButton.titleLabel.font}]; //文本尺寸
        CGSize buttonImageSize = buttonImage.size;   //图片尺寸
        _watchButton.frame = CGRectMake(BoundWidth/2-(buttonImageSize.width + buttonTitleLabelSize.width)/3,40,
                                           buttonImageSize.width + buttonTitleLabelSize.width,
                                           40);
    }
    return _watchButton;
}

-(UILabel *)otherLabel{
    if (!_otherLabel) {
        _otherLabel = [UILabel new];
        _otherLabel.text = @"其    他:";
        _otherLabel.font = [UIFont systemFontOfSize:13];
        _otherLabel.textColor = [UIColor colorFromHexCode:@"aeaeae"];
        _otherLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _otherLabel;
}


-(UILabel *)otherInfoLabel{
    if (!_otherInfoLabel) {
        _otherInfoLabel = [UILabel new];
        _otherInfoLabel.font = [UIFont systemFontOfSize:13];
        _otherInfoLabel.textColor = [UIColor blackColor];
        _otherInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _otherInfoLabel;
}

@end
