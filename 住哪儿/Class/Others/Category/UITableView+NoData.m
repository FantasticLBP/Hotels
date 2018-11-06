//
//  UITableView+NoData.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/9/15.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "UITableView+NoData.h"

@implementation UITableView (NoData)


-(void)tableViewDisplayWithMsg:(NSString *)message ifNecessaryForCount:(NSUInteger)rowCount{
    if (rowCount == 0) {
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellAccessoryNone;
    }else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}
@end
