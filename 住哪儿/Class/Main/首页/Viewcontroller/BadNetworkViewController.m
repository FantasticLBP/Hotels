
//
//  BadNetworkViewController.m
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/31.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "BadNetworkViewController.h"
#import "LBPHightedAttributedString.h"
@interface BadNetworkViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTipLabel;


@end

@implementation BadNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"解决方案";
    self.firstTipLabel.attributedText = [LBPHightedAttributedString setAllText:self.firstTipLabel.text andSpcifiStr:@"”允许“" withColor:[UIColor colorFromHexCode:@"0A60FE"] specifiStrFont:[UIFont systemFontOfSize:15]];
    self.secondTipLabel.attributedText = [LBPHightedAttributedString setAllText:self.secondTipLabel.text andSpcifiStr:@"”不允许“" withColor:[UIColor colorFromHexCode:@"0A60FE"] specifiStrFont:[UIFont systemFontOfSize:15]];
    
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel *)view;
            
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:label.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:10];
            
            [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
            label.attributedText = attributedText;
        }
    }
    
}



@end
