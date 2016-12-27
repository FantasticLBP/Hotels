


//
//  SpecialHotelConditionPickCell.m
//  住哪儿
//
//  Created by geek on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "SpecialHotelConditionPickCell.h"
@interface SpecialHotelConditionPickCell()

@property (weak, nonatomic) IBOutlet UILabel *totalNigthLabel;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@end

@implementation SpecialHotelConditionPickCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.totalNigthLabel.layer.borderWidth = 1;
    self.totalNigthLabel.layer.borderColor = PlaceHolderColor.CGColor;
    self.totalNigthLabel.layer.cornerRadius = 7;
    
    

    
    
}


@end
