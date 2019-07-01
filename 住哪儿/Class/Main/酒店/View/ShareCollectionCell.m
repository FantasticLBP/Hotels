

//
//  ShareCollectionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ShareCollectionCell.h"
@interface ShareCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *sharePlatformLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sharePlatformImageView;

@end

@implementation ShareCollectionCell

-(void)setImageName:(NSString *)imageName{
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 1;
    if ([ProjectUtil isBlank:imageName]) {
        return ;
    }
    _imageName = imageName;
    if ([imageName isEqualToString:@"Share_message"]) {
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"短信";
    }else if ([imageName isEqualToString:@"Share_qq_icon"]){
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"QQ";
    }else if ([imageName isEqualToString:@"Share_qq_zone_icon"]){
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"QQ空间";
    }else if ([imageName isEqualToString:@"Share_sina"]){
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"新浪微博";
    }else if([imageName isEqualToString:@"Share_weixin_friends"]){
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"微信好友";
    }else{
        self.sharePlatformImageView.image = [UIImage imageNamed:imageName];
        self.sharePlatformLabel.text = @"微信朋友圈";

    }
}
@end
