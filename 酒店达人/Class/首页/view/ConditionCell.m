//
//  ConditionCell.m
//  酒店达人
//
//  Created by geek on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ConditionCell.h"

@interface ConditionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation ConditionCell


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.image = [UIImage imageNamed:self.imageName];
    self.label.text = self.titleName;
}

@end
