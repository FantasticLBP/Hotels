

//
//  TableViewCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/4/19.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property(nonatomic, weak) UILabel *label;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
