
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

static NSString *CheaperHotelCellID = @"CheaperHotelCell";


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
    
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"订单填写";
    self.tableView.tableHeaderView = self.headerView;
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
        NSLog(@"去支付");
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 1 + self.specialHotels.count;
    return  5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheaperHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:CheaperHotelCellID forIndexPath:indexPath];
        return cell;
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
        [_tableView registerNib:[UINib nibWithNibName:@"CheaperHotelCell" bundle:nil] forCellReuseIdentifier:CheaperHotelCellID];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    }
    return _tableView;
}
@end
