
//
//  OrderCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *hotelLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *livingLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTypeLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
@implementation OrderCell

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.type == OrderType_WillPay) {
        [self.leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftButton.layer.borderWidth  = 1;
        self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.leftButton.layer.cornerRadius = 3;
        self.leftButton.layer.masksToBounds = YES;
        
        [self.rightButton setTitle:@"继续支付" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorFromHexCode:@"FF7F00"] forState:UIControlStateNormal];
        self.rightButton.layer.borderWidth  = 1;
        self.rightButton.layer.borderColor = [UIColor colorFromHexCode:@"FF7F00"].CGColor;
        self.rightButton.layer.cornerRadius = 3;
        self.rightButton.layer.masksToBounds = YES;
    }else if (self.type == OrderType_UnWalk) {
        [self.leftButton setTitle:@"添加提醒" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftButton.layer.borderWidth  = 1;
        self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.leftButton.layer.cornerRadius = 3;
        self.leftButton.layer.masksToBounds = YES;
        
        [self.rightButton setTitle:@"再次预定" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorFromHexCode:@"FF7F00"] forState:UIControlStateNormal];
        self.rightButton.layer.borderWidth  = 1;
        self.rightButton.layer.borderColor = [UIColor colorFromHexCode:@"FF7F00"].CGColor;
        self.rightButton.layer.cornerRadius = 3;
        self.rightButton.layer.masksToBounds = YES;
    }else if (self.type == OrderType_UnEvaluate) {
        [self.leftButton setTitle:@"订单评价" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftButton.layer.borderWidth  = 1;
        self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.leftButton.layer.cornerRadius = 3;
        self.leftButton.layer.masksToBounds = YES;
        
        [self.rightButton setTitle:@"再次预定" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorFromHexCode:@"FF7F00"] forState:UIControlStateNormal];
        self.rightButton.layer.borderWidth  = 1;
        self.rightButton.layer.borderColor = [UIColor colorFromHexCode:@"FF7F00"].CGColor;
        self.rightButton.layer.cornerRadius = 3;
        self.rightButton.layer.masksToBounds = YES;
    }else{
        [self.leftButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftButton.layer.borderWidth  = 1;
        self.leftButton.layer.borderColor = [UIColor blackColor].CGColor;
        self.leftButton.layer.cornerRadius = 3;
        self.leftButton.layer.masksToBounds = YES;
        
        [self.rightButton setTitle:@"再次预定" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorFromHexCode:@"FF7F00"] forState:UIControlStateNormal];
        self.rightButton.layer.borderWidth  = 1;
        self.rightButton.layer.borderColor = [UIColor colorFromHexCode:@"FF7F00"].CGColor;
        self.rightButton.layer.cornerRadius = 3;
        self.rightButton.layer.masksToBounds = YES;
    }
}

-(void)setModel:(OrderModel *)model{
    _model  = model;
    if (model) {
        NSDictionary *hotelDic = (NSDictionary *)model.hotel[0];
        NSDictionary *roomDic = (NSDictionary *)model.room[0];
        self.hotelLabel.text = hotelDic[@"hotelName"];
        self.roomLabel.text = roomDic[@"type"];
        self.startLabel.text = model.startTime;
        self.endLabel.text = model.endTime;
        self.livingLabel.text = [NSString stringWithFormat:@"%@晚",model.livingPeriod];
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.totalPrice];
    }
}


-(void)setType:(OrderType)type{
    _type = type;
    switch (type) {
        case OrderType_WillPay:
            self.cellTypeLabel.text = @"待付款";
            break;
        case OrderType_UnWalk:
            self.cellTypeLabel.text = @"未出行";
            break;
        case OrderType_UnEvaluate:
            self.cellTypeLabel.text = @"待评价";
            break;
        case OrderType_History:
            self.cellTypeLabel.text = @"历史记录";
            break;
        default:
            break;
    }
}

#pragma mark - button method
- (IBAction)clickLeftButton:(id)sender {
    switch (self.type) {
        case OrderType_WillPay:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_Revoke withOrderModel:self.model];
            }
            break;
        }
        case OrderType_UnWalk:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_Remind withOrderModel:self.model];
            }
            break;
        }
            
        case OrderType_UnEvaluate:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_Evaluate withOrderModel:self.model];
            }
            break;
        }
        case OrderType_History:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_Cancel withOrderModel:self.model];
            }
            break;
        }

    }
   
}

- (IBAction)clickRIghtButton:(id)sender {
    switch (self.type) {
        case OrderType_WillPay:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_Pay withOrderModel:self.model];
            }
            break;
        }
        case OrderType_UnWalk:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_ReBook withOrderModel:self.model];
            }
            break;
        }
        case OrderType_UnEvaluate:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_ReBook withOrderModel:self.model];
            }
            break;
        }
        case OrderType_History:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(orderCell:didClickButtonWithCellType: withOrderModel:)]) {
                [self.delegate orderCell:self didClickButtonWithCellType:OrderButtonOperationType_ReBook withOrderModel:self.model];
            }
            break;
        }
    }
}

@end
