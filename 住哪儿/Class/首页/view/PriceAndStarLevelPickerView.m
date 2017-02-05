

//
//  PriceAndStarLevelPickerView.m
//  住哪儿
//
//  Created by geek on 2017/2/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "PriceAndStarLevelPickerView.h"
#import "LiuXSlider.h"

@interface PriceAndStarLevelPickerView()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *boundary;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) LiuXSlider *pricePicker;



@end

@implementation PriceAndStarLevelPickerView

#pragma mark - 
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:CGRectMake(0, BoundHeight-340, BoundWidth, 340)]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.priceLabel];
    [self addSubview:self.boundary];
    [self addSubview:self.clearButton];
    [self addSubview:self.okButton];
    [self addSubview:self.pricePicker];
    self.pricePicker.block = ^(int index){
        NSLog(@"当前index==%d",index);
    };
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self.boundary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self).with.offset(50);
        make.height.mas_equalTo(1);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.bottom.equalTo(self).with.offset(-12);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clearButton.mas_right).with.offset(12);
        make.right.equalTo(self).with.offset(-12);
        make.bottom.equalTo(self.clearButton.mas_bottom);
        make.height.mas_equalTo(40);
    }];
}


#pragma mark - button methd
-(void)clearChoosen{
    if (self.delegate && [self.delegate respondsToSelector:@selector(priceAndStarLevelPickerView:didClickWithhButtonType:)]) {
        [self.delegate priceAndStarLevelPickerView:self didClickWithhButtonType:PriceAndStarLevel_Operation_clearCondition];
    }
}

-(void)verifyChoosen{
    if (self.delegate && [self.delegate respondsToSelector:@selector(priceAndStarLevelPickerView:didClickWithhButtonType:)]) {
        [self.delegate priceAndStarLevelPickerView:self didClickWithhButtonType:PriceAndStarLevel_Operation_OK];
    }
}

#pragma mark - lazy load
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.text = @"价格星级";
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceLabel;
}

-(UIView *)boundary{
    if (!_boundary) {
        _boundary = [UIView new];
        _boundary.backgroundColor = CollectionViewBackgroundColor;
    }
    return _boundary;
}

-(UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setTitle:@"清空选项" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _clearButton.backgroundColor = [UIColor whiteColor];
        _clearButton.layer.borderWidth = 1;
        _clearButton.layer.borderColor = GlobalMainColor.CGColor;
        _clearButton.layer.cornerRadius = 3;
        [_clearButton addTarget:self action:@selector(clearChoosen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

-(UIButton *)okButton{
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        _okButton.backgroundColor = GlobalMainColor;
        _okButton.layer.cornerRadius = 3;
        [_okButton addTarget:self action:@selector(verifyChoosen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

-(LiuXSlider *)pricePicker{
    if (!_pricePicker) {
        _pricePicker = [[LiuXSlider alloc] initWithFrame:CGRectMake(25, 215, BoundWidth-50, 30) titles:@[@"0元",@"50元",@"100元",@"150元",@"200元",@"250元",@"300元"] firstAndLastTitles:@[@"0元",@"300元"] defaultIndex:0 sliderImage:[UIImage imageNamed:@"日历"]];
    }
    return _pricePicker;
}
@end
