//
//  ConditionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ConditionCell.h"

@interface ConditionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ConditionCell

-(void)setImageName:(NSString *)imageName{
    LBPLog(@"set-titileName:%@",self.titleName);
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:self.imageName];
}

-(void)setTitleName:(NSString *)titleName{
    LBPLog(@"set-imageName:%@",self.imageName);
    _titleName = titleName;
    self.label.text = self.titleName;
}

@end
