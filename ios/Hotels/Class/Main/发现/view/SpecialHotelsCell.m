//
//  SpecialHotelCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/3/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "SpecialHotelsCell.h"
@interface SpecialHotelsCell()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMargin;

@end
@implementation SpecialHotelsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.descriptionLabel.layer.borderWidth = 2;
    self.descriptionLabel.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:23]};
    CGSize size=[self.name sizeWithAttributes:attrs];
    
    self.leftMargin.constant = BoundWidth/2 - size.width/2 - 30;
    self.rightMargin.constant = BoundWidth/2 - size.width/2 - 30;
}

-(void)setName:(NSString *)name{
    _name = name;
    self.descriptionLabel.text = self.name;
}

@end
