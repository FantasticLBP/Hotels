
//
//  HotelNoticeCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelNoticeCell.h"

@interface HotelNoticeCell()
@property (nonatomic, strong) UILabel *waringLabel;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *topView;
@end

@implementation HotelNoticeCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.topView];
    [self addSubview:self.waringLabel];
    [self addSubview:self.noticeLabel];
    [self addSubview:self.contentLabel];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    [self.waringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self.topView.mas_bottom).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_equalTo(21);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.waringLabel);
        make.top.equalTo(self.waringLabel.mas_bottom).with.offset(3);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(21);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeLabel.mas_right).with.offset(2);
        make.top.equalTo(self.noticeLabel);
        make.right.equalTo(self);
        make.height.mas_equalTo(21);
    }];
}

#pragma mark - lazy load
-(UILabel *)waringLabel{
    if (!_waringLabel) {
        _waringLabel = [UILabel new];
        _waringLabel.text = @"温馨提示";
        _waringLabel.textColor = [UIColor blackColor];
        _waringLabel.textAlignment = NSTextAlignmentLeft;
        _waringLabel.font = [UIFont systemFontOfSize:18];
    }
    return _waringLabel;
}

-(UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [UILabel new];
        _noticeLabel.text = @"入离通知：";
        _noticeLabel.textColor = [UIColor colorFromHexCode:@"bcbcbc"];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _noticeLabel;
}


-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"入住时间：12点以后，离店时间：12点以前";
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor colorFromHexCode:@"f4f4f4"];
    }
    return _topView;
}

@end

