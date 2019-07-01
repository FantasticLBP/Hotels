

//
//  HotelTimeCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/26.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelTimeCell.h"

@interface HotelTimeCell()
@property (weak, nonatomic) IBOutlet UILabel *nightNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaverDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaveDayLabel;

@end

@implementation HotelTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nightNumLabel.layer.borderWidth = 1;
    self.nightNumLabel.layer.borderColor = PlaceHolderColor.CGColor;
    self.nightNumLabel.layer.cornerRadius = 7;
    self.nightNumLabel.layer.masksToBounds = YES;
}


#pragma mark - setter
-(void)setStartPeriod:(NSString *)startPeriod{
    _startPeriod = startPeriod;
    if ([ProjectUtil isNotBlank:startPeriod]) {
        self.startDateLabel.text = startPeriod;
    }else{
        self.startDateLabel.text = [[NSDate sharedInstance] today];
        self.startDayLabel.text = @"今天";
    }
}

-(void)setLeavePerios:(NSString *)leavePerios{
    _leavePerios = leavePerios;
    if ([ProjectUtil isNotBlank:leavePerios]) {
        self.leaverDateLabel.text = [NSString stringWithFormat:@"%@月%@日",[leavePerios substringToIndex:2],[leavePerios substringFromIndex:3]];
        
        //共几天
        self.nightNumLabel.text = [NSString stringWithFormat:@"共%zd晚", [[NSDate sharedInstance] calcDaysFromBegin:self.startPeriod end:leavePerios]];
    }else{
        self.leaverDateLabel.text = [[NSDate sharedInstance] GetTomorrowDay];
        self.leaveDayLabel.text = @"明天";
    }
}





@end
