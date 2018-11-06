
//
//  RoomItemCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "RoomItemCell.h"
@interface RoomItemCell()
@property (weak, nonatomic) IBOutlet UILabel *priceTypeLabel;  /**<价格类型*/
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookLabel;

@end
@implementation RoomItemCell

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *book = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookRoom)];
    book.cancelsTouchesInView = YES;
    self.bookLabel.userInteractionEnabled = YES;
    [self.bookLabel addGestureRecognizer:book];
}

-(void)bookRoom{
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomItemCell:didBookRoom: price:)]) {
        [self.delegate roomItemCell:self didBookRoom:YES price:self.price];
    }
}


-(void)setPrice:(NSString *)price{
    _price = price;
    if ([ProjectUtil isNotBlank:price]) {
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
    }
}

-(void)setPriceType:(NSString *)priceType{
    _priceType = priceType;
    self.priceTypeLabel.text = priceType;
}
@end
