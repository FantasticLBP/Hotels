//
//  RoomBaseInfoView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "RoomBaseInfoView.h"

@interface RoomBaseInfoView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end
@implementation RoomBaseInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).with.offset(10);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width-49, self.frame.size.height));
    }];
}

-(void)initViewWithImageName:(NSString *)image andLabelText:(NSString *)text{
    [self setupUI];
    if ([ProjectUtil isNotBlank:image]) {
        self.imageView.image = [UIImage imageNamed:image];
    }
    
    if ([ProjectUtil isNotBlank:text]) {
        self.label.text = text;
    }
}

#pragma mark - lazy load
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor colorFromHexCode:@"aeaeae"];
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}
@end
