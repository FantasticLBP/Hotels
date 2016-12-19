
//
//  HotelDescriptionCell.m
//  酒店达人
//
//  Created by geek on 2016/12/12.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelDescriptionCell.h"
@interface HotelDescriptionCell()
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;

@end
@implementation HotelDescriptionCell

-(void)setHotelImageName:(NSString *)hotelImageName{
    _hotelImageName = hotelImageName;
    self.hotelImageView.image = [UIImage imageNamed:hotelImageName];
}

@end
