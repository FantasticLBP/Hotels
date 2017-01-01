

//
//  RoomInfoHeaderView.m
//  住哪儿
//
//  Created by geek on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "RoomInfoHeaderView.h"
#import "RoomBaseInfoView.h"

#define FindDownImageWIdth 16


@interface RoomInfoHeaderView()
@property (nonatomic, strong) UIImageView *roomImage;
@property (nonatomic, strong) UILabel *roomLabel;
@property (nonatomic, strong) UIButton *watchButton;
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
}

-(void)watchMoreRoomInfo{
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomInfoHeaderView:didOperateWithTag:)]) {
        [self.delegate roomInfoHeaderView:self didOperateWithTag:RoomOperationType_MoreInfo];
    }
}

-(void)setRoomName:(NSString *)roomName{
    _roomName = roomName;
    if ([ProjectUtil isBlank:roomName]) {
        return ;
    }
    self.roomLabel.text = roomName;
    self.roomImage.image = [UIImage imageNamed:@"jpg-9"];
}

#pragma mark - lazy load
-(UIImageView *)roomImage{
    if (!_roomImage) {
        _roomImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
        _roomImage.layer.cornerRadius = 5.0f;
        _roomImage.layer.masksToBounds = YES;
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
        UIImage *buttonImage = [UIImage imageNamed:@"Hotel_moreInfo"];
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
                                           buttonImageSize.height);
    }
    return _watchButton;
}



@end
