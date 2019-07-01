
//
//  OrderCompletedFirstCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/7.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderCompletedFirstCell.h"

@interface OrderCompletedFirstCell()
@property (nonatomic, strong) UIImageView *completeImageView;
@property (nonatomic, strong) UILabel *resultLabel

;
@end

@implementation OrderCompletedFirstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.completeImageView];
    [self addSubview:self.resultLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.completeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(BoundWidth/2-100);
        make.top.equalTo(self).with.offset(31);
        make.size.mas_offset(CGSizeMake(33, 33));
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.completeImageView.mas_right);
        make.top.equalTo(self.completeImageView);
        make.bottom.equalTo(self.completeImageView);
        make.width.mas_equalTo(112);

    }];
}

#pragma mark - lazy load
-(UIImageView *)completeImageView{
    if (!_completeImageView) {
        _completeImageView = [UIImageView new];
        _completeImageView.image = [UIImage imageNamed:@"Order_complete"];
    }
    return _completeImageView;
}

-(UILabel *)resultLabel{
    if (!_resultLabel) {
        _resultLabel = [UILabel new];
        _resultLabel.text = @"订单提交成功";
        _resultLabel.textColor = [UIColor blackColor];
        _resultLabel.font = [UIFont systemFontOfSize:18];
        _resultLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _resultLabel;
}


@end

