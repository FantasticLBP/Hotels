

//
//  PriceAndStarLevelPickerView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/2/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "PriceAndStarLevelPickerView.h"
#import "LiuXSlider.h"

@interface PriceAndStarLevelPickerView()
@property (nonatomic, strong) UILabel *priceStarLabel;
@property (nonatomic, strong) UIView *boundary;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) LiuXSlider *pricePicker;
@property (nonatomic, strong) UILabel *pricelLabel;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UIButton *noConditionButton;          //不限
@property (nonatomic, strong) UIButton *cheapButton;                //经济
@property (nonatomic, strong) UIButton *threeStarsButton;           //三星
@property (nonatomic, strong) UIButton *fourStarsButton;            //四星
@property (nonatomic, strong) UIButton *fiveStarsButton;            //五星

@property (nonatomic, strong) NSMutableDictionary *data;                   //选择结果
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
    [self addSubview:self.priceStarLabel];
    [self addSubview:self.boundary];
    [self addSubview:self.clearButton];
    [self addSubview:self.okButton];
    [self addSubview:self.pricePicker];
    __weak typeof(self) Weakself = self;
    self.pricePicker.block = ^(int index){
        switch (index) {
            case 0:
                Weakself.data[@"price"] =  @(Hotel_Price_Level_Zero);
                break;
            case 1:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_Fifty);
                break;
            case 2:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_Hundred);
                break;
            case 3:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_HundredFifty);
                break;
            case 4:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_TwoHundred);
                break;
            case 5:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_TwoHundredFifty);
                break;
            case 6:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_ThreeHundred);
                break;
            case 7:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_ThreeHundredFifty);
                break;
            case 8:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_FourHundred);
                break;
            case 9:
                Weakself.data[@"price"] =  @(Hotel_Star_Level_NoLimit);
                break;
        }
    };
    [self addSubview:self.pricelLabel];
    [self addSubview:self.starLabel];
    for (int i=0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(12+i*(BoundWidth-26)/5, 106, (BoundWidth-26)/5, 50);
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:GlobalMainColor forState:UIControlStateSelected];
        button.layer.borderWidth = 1;
        if (button.selected) {
            button.layer.borderColor = GlobalMainColor.CGColor;
        }else{
            button.layer.borderColor = [UIColor blackColor].CGColor;
        }
        
        switch (i) {
            case 0:
                [button setTitle:@"不限" forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:@"经济" forState:UIControlStateNormal];
                break;
            case 2:
                [button setTitle:@"三星级" forState:UIControlStateNormal];
                break;
            case 3:
                [button setTitle:@"四星级" forState:UIControlStateNormal];
                break;
            case 4:
                [button setTitle:@"五星级" forState:UIControlStateNormal];
                break;
        }
        [button addTarget:self action:@selector(chooseStarLevel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.priceStarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.pricelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(-135);
        make.height.mas_equalTo(30);
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(12);
        make.right.equalTo(self);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.boundary.mas_bottom).with.offset(5);
    }];
}


#pragma mark - button methd
-(void)clearChoosen{
    if (self.delegate && [self.delegate respondsToSelector:@selector(priceAndStarLevelPickerView:didClickWithhButtonType:withData:)]) {
        [self.delegate priceAndStarLevelPickerView:self didClickWithhButtonType:PriceAndStarLevel_Operation_clearCondition withData:self.data];
    }
}

-(void)verifyChoosen{
    if (self.delegate && [self.delegate respondsToSelector:@selector(priceAndStarLevelPickerView:didClickWithhButtonType:withData:)]) {
        [self.delegate  priceAndStarLevelPickerView:self didClickWithhButtonType:PriceAndStarLevel_Operation_OK withData:self.data];
    }
}

-(void)chooseStarLevel:(UIButton *)sender{
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            if ( button.tag == sender.tag) {
                button.selected = YES;
                switch (sender.tag) {
                    case 0:
                        self.data[@"starLevel"] = @(Hotel_Star_Level_No);
                        break;
                    case 1:
                        self.data[@"starLevel"] = @(Hotel_Star_Level_Cheap);
                        break;
                    case 2:
                        self.data[@"starLevel"] = @(Hotel_Star_Level_ThreeStar);
                        break;
                    case 3:
                        self.data[@"starLevel"] = @(Hotel_Star_Level_FourStar);
                        break;
                    case 4:
                        self.data[@"starLevel"] = @(Hotel_Star_Level_FiveStar);
                        break;
                }
            }else{
               button.selected = NO;
            }
        }
    }
}

-(void)refreshUI{
    LBPLog(@"刷新界面");
}

#pragma mark - lazy load
-(UILabel *)priceStarLabel{
    if (!_priceStarLabel) {
        _priceStarLabel = [UILabel new];
        _priceStarLabel.text = @"价格星级";
        _priceStarLabel.textAlignment = NSTextAlignmentCenter;
        _priceStarLabel.textColor = [UIColor blackColor];
        _priceStarLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceStarLabel;
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
        [_clearButton setTitle:@"清空选择" forState:UIControlStateNormal];
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
        _pricePicker = [[LiuXSlider alloc] initWithFrame:CGRectMake(25, 215, BoundWidth-50, 30) titles:@[@"0元",@"50元",@"100元",@"150元",@"200元",@"250元",@"300元",@"350元",@"400元",@"不限"] firstAndLastTitles:@[@"0元",@"不限"] defaultIndex:0 sliderImage:[UIImage imageNamed:@"Home_pricePicker"]];
    }
    return _pricePicker;
}


-(UILabel *)pricelLabel{
    if (!_pricelLabel) {
        _pricelLabel = [UILabel new];
        _pricelLabel.text = @"价格";
        _pricelLabel.textAlignment = NSTextAlignmentLeft;
        _pricelLabel.font = [UIFont systemFontOfSize:14];
        _pricelLabel.textColor = [UIColor blackColor];
    }
    return _pricelLabel;
}

-(UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [UILabel new];
        _starLabel.text = @"星级（可多选）";
        _starLabel.textAlignment = NSTextAlignmentLeft;
        _starLabel.textColor = [UIColor blackColor];
        _starLabel.font = [UIFont systemFontOfSize:14];
    }
    return _starLabel;
}

-(NSMutableDictionary *)data{
    if (!_data) {
        _data = [[NSMutableDictionary alloc] init];
    }
    return _data;
}
@end
