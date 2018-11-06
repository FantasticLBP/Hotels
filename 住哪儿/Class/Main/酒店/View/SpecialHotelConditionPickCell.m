


//
//  SpecialHotelConditionPickCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "SpecialHotelConditionPickCell.h"



@interface SpecialHotelConditionPickCell()

@property (weak, nonatomic) IBOutlet UILabel *totalNigthLabel;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *locateButton;
@property (weak, nonatomic) IBOutlet UIButton *beginTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@end

@implementation SpecialHotelConditionPickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.totalNigthLabel.layer.borderWidth = 1;
    self.totalNigthLabel.layer.borderColor = PlaceHolderColor.CGColor;
    self.totalNigthLabel.layer.cornerRadius = 7;
    
}


#pragma mark - button method
- (IBAction)clickSelectCityButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(specialHotelConditionPickCell:didClickWithAxctionType:)]) {
        [self.delegate specialHotelConditionPickCell:self didClickWithAxctionType:Operation_Type_Locate];
    }
}

- (IBAction)clickLocateButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(specialHotelConditionPickCell:didClickWithAxctionType:)]) {
        [self.delegate specialHotelConditionPickCell:self didClickWithAxctionType:Operation_Type_AutoLocate];
    }
}


- (IBAction)clickBeiginTimeButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(specialHotelConditionPickCell:didClickWithAxctionType:)]) {
        [self.delegate specialHotelConditionPickCell:self didClickWithAxctionType:Operation_Type_InTime];
    }
    
}

- (IBAction)clickEndTimeButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(specialHotelConditionPickCell:didClickWithAxctionType:)]) {
        [self.delegate specialHotelConditionPickCell:self didClickWithAxctionType:Operation_Type_EndTime];
    }
}

- (IBAction)clickSerachHotelButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(specialHotelConditionPickCell:didClickWithAxctionType:)]) {
        [self.delegate specialHotelConditionPickCell:self didClickWithAxctionType:Operation_Type_SearchHotel];
    }
}


@end
