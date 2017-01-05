
//
//  OrderCell.m
//  住哪儿
//
//  Created by geek on 2017/1/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
@implementation OrderCell


-(void)setPrice:(NSString *)price{
    price = @"123";
    _price = price;
    if ([ProjectUtil isNotBlank:price]) {
        self.priceLabel.text = [@"¥" stringByAppendingString:price];
        [self.priceLabel sizeToFit];
    }
}

@end
