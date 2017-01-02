
//
//  RoomItemCell.m
//  住哪儿
//
//  Created by geek on 2017/1/1.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "RoomItemCell.h"
@interface RoomItemCell()

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(roomItemCell:didBookRoom:)]) {
        [self.delegate roomItemCell:self didBookRoom:YES];
    }
}

@end
