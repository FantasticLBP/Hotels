

//
//  TopicHotelCollectionCell.m
//  住哪儿
//
//  Created by geek on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelCollectionCell.h"

@interface TopicHotelCollectionCell()


@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@end

@implementation TopicHotelCollectionCell

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.topicImageView.image = [UIImage imageNamed:imageName];
}

-(void)setTopicName:(NSString *)topicName{
    _topicName = topicName;
    self.topicLabel.text = topicName;
    [self.topicLabel sizeToFit];
}

@end
