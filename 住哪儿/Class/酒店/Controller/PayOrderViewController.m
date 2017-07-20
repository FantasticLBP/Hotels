
//  PayOrderViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "PayOrderViewController.h"
#import "OrderHeaderView.h"
#import "OrderFillFooterView.h"
#import "OrderResultViewController.h"

@interface PayOrderViewController ()<OrderFillFooterViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderHeaderView *headerView;
@property (nonatomic, strong) OrderFillFooterView *footerView;

@end

@implementation PayOrderViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"支付订单";
    self.headerView.hotelName = self.hotelmodel.hotelName;;
    self.headerView.chechinTime = self.startPeriod;
    self.headerView.checkoutTime = [ProjectUtil isNotBlank:self.leavePerios]?[NSString stringWithFormat:@"%@月%@日",[self.leavePerios substringToIndex:2],[self.leavePerios substringFromIndex:3]]:@"";
    self.headerView.totalNight = self.livingPeriod;
    self.headerView.roomDetail = self.model.type;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.footerView.price = @"198";
    [self.tableView addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
}

-(void)payInRestMoney:(UISwitch *)switcher{
    
}

#pragma mark - OrderFillFooterViewDelegate
-(void)orderFillFooterView:(OrderFillFooterView *)view didClickPayButton:(BOOL)flag{
    if (flag) {
        [SVProgressHUD showInfoWithStatus:@"正在支付"];
        NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/pay.php"];
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        para[@"key"] = AppKey;
        para[@"orderId"] = self.orderId;
        
        [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"code"] integerValue] == 200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    OrderResultViewController *vc = [[OrderResultViewController alloc] init];
                    vc.orderId = self.orderId;
                    vc.startPeriod = self.startPeriod;
                    vc.leavePerios = self.leavePerios;
                    vc.model = self.model;
                    vc.hotelmodel = self.hotelmodel;
                    vc.livingPeriod = self.livingPeriod;
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
        } fail:^{
            [SVProgressHUD dismiss];
        }];
    }
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
                UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 96, 44)];
                accountLabel.text = @"使用现金账户";
                accountLabel.textColor = [UIColor colorFromHexCode:@"8e8e8e"];
                accountLabel.font = [UIFont systemFontOfSize:15];
                accountLabel.textAlignment = NSTextAlignmentLeft;
                
                UILabel *restLabel = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth-160, 0, 32, 44)];
                restLabel.text = @"余额";
                restLabel.textColor = [UIColor colorFromHexCode:@"8e8e8e"];
                restLabel.font = [UIFont systemFontOfSize:15];
                restLabel.textAlignment = NSTextAlignmentLeft;

                UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth-120, 0, 64, 44)];
                moneyLabel.text = @"¥0.00";
                moneyLabel.textColor = [UIColor colorFromHexCode:@"8e8e8e"];
                moneyLabel.font = [UIFont systemFontOfSize:15];
                moneyLabel.textAlignment = NSTextAlignmentLeft;
                
                UISwitch *switcher = [[UISwitch alloc] initWithFrame:CGRectMake(BoundWidth-60, 22-18, 60, 36)];
                switcher.onTintColor = GlobalMainColor;
                [switcher addTarget:self action:@selector(payInRestMoney:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:accountLabel];
                [cell addSubview:restLabel];
                [cell addSubview:moneyLabel];
                [cell addSubview:switcher];
    }else if(indexPath.section == 1  ){
        switch (indexPath.row) {
            case 0:{
                UILabel *payMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 96, 44)];
                payMethodLabel.text = @"选择支付方式";
                payMethodLabel.textColor = [UIColor colorFromHexCode:@"8e8e8e"];
                payMethodLabel.font = [UIFont systemFontOfSize:15];
                payMethodLabel.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:payMethodLabel];
                break;
            }
            case 1:{
                UIImageView *aliPayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 22-17, 34, 34)];
                aliPayImageView.image = [UIImage imageNamed:@"Hotel_alipay"];
            
                UILabel *alipayLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 80, 44)];
                alipayLabel.text = @"支付宝支付";
                alipayLabel.textColor = [UIColor blackColor];
                alipayLabel.font = [UIFont systemFontOfSize:13];
                
                [cell.contentView addSubview:aliPayImageView];
                [cell.contentView addSubview:alipayLabel];
                break;
            }
            case 2:{
                UIImageView *wechatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 22-17, 34, 34)];
                wechatImageView.image = [UIImage imageNamed:@"Hotel_wechat"];
                
                UILabel *wechatPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 64, 44)];
                wechatPayLabel.text = @"微信支付";
                wechatPayLabel.textColor = [UIColor blackColor];
                wechatPayLabel.font = [UIFont systemFontOfSize:13];
                
                [cell.contentView addSubview:wechatImageView];
                [cell.contentView addSubview:wechatPayLabel];
                
                break;
            }
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 ) {
        return 10;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *indexpath1 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *indexpath2 = [NSIndexPath indexPathForRow:2 inSection:1];
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = [tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    
    if ( [tableView cellForRowAtIndexPath:indexpath1].accessoryType == UITableViewCellAccessoryCheckmark ) {
        [tableView cellForRowAtIndexPath:indexpath2].accessoryType = UITableViewCellAccessoryNone;
    }
    if ( [tableView cellForRowAtIndexPath:indexpath2].accessoryType == UITableViewCellAccessoryCheckmark ) {
        [tableView cellForRowAtIndexPath:indexpath1].accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.section == 1 ) {
        if (indexPath.row == 1) {
            LBPLog(@"支付宝支付");
        }else{
            LBPLog(@"微信支付");
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
}


#pragma mark - lazy load
-(OrderHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 137)];
        _headerView.type = OrderHeaderType_Pay;

    }
    return _headerView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    }
    return _tableView;
}

-(OrderFillFooterView *)footerView{
    if (!_footerView) {
        _footerView = [OrderFillFooterView new];
        _footerView.delegate = self;
    }
    return _footerView;
}
@end
