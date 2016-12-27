

//
//  HotelTimeCell.m
//  住哪儿
//
//  Created by geek on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelTimeCell.h"

@interface HotelTimeCell()
@property (weak, nonatomic) IBOutlet UILabel *nightNumLabel;


@end

@implementation HotelTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nightNumLabel.layer.borderWidth = 1;
    self.nightNumLabel.layer.borderColor = PlaceHolderColor.CGColor;
    self.nightNumLabel.layer.cornerRadius = 7;
    self.nightNumLabel.layer.masksToBounds = YES;
}



@end
