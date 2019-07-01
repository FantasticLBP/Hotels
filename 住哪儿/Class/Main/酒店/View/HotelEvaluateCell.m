
//
//  HotelEvaluateCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelEvaluateCell.h"

@interface HotelEvaluateCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImageV;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel     *evaluationDetailsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *satifyImageV;
@property (strong, nonatomic) IBOutlet UIImageView *goodRateImage;
@property (weak, nonatomic) IBOutlet UILabel *noCommentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;

@end
@implementation HotelEvaluateCell

-(void)setNeedsLayout{
    [super setNeedsLayout];
    self.userImageV.layer.cornerRadius=self.userImageV.image.size.width/2;
    self.userImageV.image=[UIImage imageNamed:@"consult_doctor_icon"];
}

-(void)setHidden:(BOOL)hidden{
    _hidden = hidden;
    self.noCommentLabel.hidden = hidden;
}

-(void)createCellWithDictionary:(NSDictionary *)dict withNoCommentFlag:(BOOL)flag{
    if (dict[@"Name"] == nil || dict[@"Name"] == NULL ||[dict[@"Name"] isKindOfClass:[NSNull class]] || [[dict[@"Name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.scoreLabel.text = @"";
    }else{
        self.scoreLabel.text = dict[@"Name"];
    }
    if (dict[@"EvaluateContent"] == nil || dict[@"EvaluateContent"] == NULL ||[dict[@"EvaluateContent"] isKindOfClass:[NSNull class]] || [[dict[@"EvaluateContent"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.evaluationDetailsLabel.text = @"";
    }else{
        self.evaluationDetailsLabel.text = dict[@"EvaluateContent"];
    }
    
    if (dict[@"Score"]) {
        self.goodRateImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"five_star%@",dict[@"Score"]]];
    }
    
    
    if (flag) {
        self.userImageV.hidden = YES;
        self.scoreLabel.hidden = YES;
        self.evaluationDetailsLabel.hidden = YES;
        self.satifyImageV.hidden = YES;
        self.goodRateImage.hidden = YES;
        self.noCommentLabel.hidden = NO;
    }else{
        self.userImageV.hidden = NO;
        self.scoreLabel.hidden = NO;
        self.evaluationDetailsLabel.hidden = NO;
        self.satifyImageV.hidden = NO;
        self.goodRateImage.hidden = NO;
        self.noCommentLabel.hidden = YES;
    }
    
    
    self.evaluationDetailsLabel.numberOfLines = 0;
    self.labelHeight.constant = [dict[@"EvaluateContent"] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap].height+10;
}


@end
