

//
//  TopicHotelCollectionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelCollectionCell.h"

@interface TopicHotelCollectionCell()


@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@end

@implementation TopicHotelCollectionCell

-(void)setData:(NSDictionary *)data{
    _data = data;
    self.topicLabel.text = [ProjectUtil isNotBlank:data[@"subject"]] ? data[@"subject"] : @"";
    [self.topicLabel sizeToFit];
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,data[@"image"]];
    [self.topicImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Hotel_placeholder"]];

}


@end
