
//
//  HotelDetailImageCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelDetailImageCell.h"

@interface HotelDetailImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;

@end

@implementation HotelDetailImageCell

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    [self.hotelImageView sd_setImageWithURL:[NSURL URLWithString:self.imageName] placeholderImage:[UIImage imageNamed:@"Hotel_placeholder"]];
}

@end
