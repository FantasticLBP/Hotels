
//
//  HotelOrderFillVC.m
//  住哪儿
//
//  Created by geek on 2017/1/2.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "HotelOrderFillVC.h"
#import "UIViewController+BackButtonHandler.h"
#import "OrderFillFooterView.h"
#import "OrderHeaderView.h"
#import "CheaperHotelCell.h"
#import "PayOrderViewController.h"

static NSString *OrderCellID = @"OrderCell";


@interface HotelOrderFillVC ()<OrderFillFooterViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) OrderFillFooterView *footerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderHeaderView *headerView;

@end

@implementation HotelOrderFillVC

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
    self.title = @"订单填写";
    self.headerView.hotelName = @"杭州溪悠居快捷酒店";
    self.headerView.chechinTime = @"1月2日（今天）";
    self.headerView.checkoutTime = @"1月3日（明天）";
    self.headerView.totalNight = @"1晚";
    self.headerView.roomDetail = @"豪华标间 无早";
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, BoundWidth-26, 30)];
        label.text = @"因故无法入住，在理赔范围内可获最高90%赔偿";
        label.textColor = [UIColor colorFromHexCode:@"aeaeae"];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label;
    });
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

#pragma mark - 
- (BOOL)navigationShouldPopOnBackButton{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"您的订单尚未完成，是否确定要离开当前页面？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    return NO;
}

#pragma mark - OrderFillFooterViewDelegate
-(void)orderFillFooterView:(OrderFillFooterView *)view didClickPayButton:(BOOL)flag{
    if (flag) {
        [SVProgressHUD showWithStatus:@"正在生成订单" maskType:SVProgressHUDMaskTypeClear];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            PayOrderViewController *payVC = [[PayOrderViewController alloc] init];
            [self.navigationController pushViewController:payVC animated:YES];
        });
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OrderCellID];
    }
    
    if (indexPath.section == 0) {
        switch ( indexPath.row) {
            case 0:
                cell.textLabel.text = @"房间数";
                cell.detailTextLabel.text = @"1间";
                break;
            case 1:
                cell.textLabel.text = @"最晚到店";
                cell.detailTextLabel.text = @"14:00";
                break;
            case 2:
                cell.textLabel.text = @"入住人";
                cell.detailTextLabel.text = @"哈哈";
                break;
            case 3:
                cell.textLabel.text = @"联系人";
                cell.detailTextLabel.text = @"18968103090";
                break;
        }
    }else if(indexPath.section == 1  && indexPath.row == 0){
       cell.textLabel.text = @"发票";
        cell.detailTextLabel.text = @"如需发票，请到酒店前台索取";
    }else{
        cell.textLabel.text = @"取消险";
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = @"25元";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 2) {
        return 10;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsMake(cell.frame.size.height-1, 12, 0, 12);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
}

#pragma mark - lazy load
-(OrderFillFooterView *)footerView{
    if (!_footerView) {
        _footerView = [OrderFillFooterView new];
        _footerView.delegate = self;
    }
    return _footerView;
}

-(OrderHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[OrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 194)];
        _headerView.type = OrderHeaderType_Order;
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
@end
