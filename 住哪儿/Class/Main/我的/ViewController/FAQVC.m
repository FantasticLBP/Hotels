
//
//  FAQVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/11/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "FAQVC.h"

@interface FAQVC ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation FAQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.textView.editable = NO;
    self.textView.text = @"1. 如何预订房间？\n答：选择城市后，您可以根据一些具体条件，如日期、价格、房型、区域等再次筛选。选择房间时，请仔细阅读房屋描述、配套设施情况和交易规则，同时与房东或在日历中确认您要入住的日期是否有房，点击‘立即预订’即可下单。\n2. 什么时候才算预订成功？\n 答：只有当您成功支付且房东确认了您的订单之后，才算预订成功。此时，您会收到含有房东电话的短信。（若您成功支付但房东拒绝了您的订单，住哪儿将全额退款）。\n 3. 为什么没有显示房东的地址和电话？\n 答：为了保障房东、房客双方的权益，只有当您预订成功后，系统才会提供房东的联系方式、详细地址等信息。在此之前，您可以通过与房东在线联系来了解相关信息。\n 4.为什么预订后的单价和日价不一样？\n 答：房屋价格分为日价、特殊价和折扣价。建议查看预订日期中是否有特殊价，或者通过价格明细查看预订日期中每一天的房价。\n5.可以先看房再付款吗？\n 答：目前不提供线下看房服务，网站会要求房东提供真实图片，如在入住时遇到问题，请及时联系住哪儿短租。\n 6.取消订单后多久可以收到退款？\n 答：取消订单后，会按照交易规则退款，所退款项会原路返回到支付账户中。支付方式不同，到账时间也会不同，其中支付宝1-2个工作日到账，银行卡3-7个工作日，信用卡15-20个工作日到账。";
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"常见问题解答";
    self.view.backgroundColor = TableViewBackgroundColor;
    [self.view addSubview:self.textView];
}

#pragma mark - lazy load
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, BoundWidth-16, BoundHeight)];
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.showsVerticalScrollIndicator = NO;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
        _textView.attributedText = [[NSAttributedString alloc]initWithString:@"    " attributes:attributes];
        
    
    }
    return _textView;
}

@end
