
//
//  HotelDescriptionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/12.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelDescriptionCell.h"
@interface HotelDescriptionCell()
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;


@end
@implementation HotelDescriptionCell

-(void)setModel:(HotelsModel *)model{
    _model = model;
    if ([ProjectUtil isNotBlank:model.image1]) {
            [self.hotelImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",Base_Url,model.image1]] placeholderImage:[UIImage imageNamed:@"jpg-1"]];
    }
    self.hotelNameLabel.text = [ProjectUtil isNotBlank:model.hotelName] ? model.hotelName : @"";
    
    
    self.priceLabel.text = [ProjectUtil isNotBlank:model.minPrice] ? model.minPrice : @"";
    self.subjectLabel.text =  [ProjectUtil isNotBlank:[NSString stringWithFormat:@"%zd",model.
                                                       subject]] ? [ProjectUtil getSubject:model.subject ]: @"";
    
    if (model.kindType == 1) {
        self.descriptionLabel.text = [ProjectUtil isNotBlank:model.address] ? model.address : @"";
    }else if (model.kindType == 3){
         self.descriptionLabel.text = [ProjectUtil isNotBlank:model.kindDescription] ? model.kindDescription : @"";
    }
}

@end
