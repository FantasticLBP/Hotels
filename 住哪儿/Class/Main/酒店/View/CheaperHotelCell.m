
//
//  CheaperHotelCell.m
//  幸运计划助手
//
//  Created by 杭城小刘 on 2016/12/23.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "CheaperHotelCell.h"

@interface CheaperHotelCell()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;


@end

@implementation CheaperHotelCell

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.typeLabel sizeToFit];
    
 
}



@end
