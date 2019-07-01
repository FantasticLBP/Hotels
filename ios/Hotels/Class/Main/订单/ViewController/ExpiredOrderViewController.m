
//
//  UnpayedOrderViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ExpiredOrderViewController.h"
#import "OrderModel.h"


static NSString *OrderCellId = @"OrderCell";
@interface ExpiredOrderViewController ()<UITableViewDelegate,UITableViewDataSource,
OrderCellDelegte>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;                          /**<页码*/
@property (nonatomic, strong) NSMutableArray *orders;           /**<订单数据源*/

@end

@implementation ExpiredOrderViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearData) name:LogoutNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page  = 1;
    [self reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

-(void)clearData{
    [self.orders removeAllObjects];
    [self.tableView reloadData];

}

-(void)reloadData{
    self.page = 1;
    if ([ProjectUtil isBlank:[UserManager getUserObject].telephone]) {
        [self.tableView.mj_header endRefreshing];
        [self showHint:@"请先登录"];
        return ;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/orderList.php"];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"page"] = @(self.page);
    par[@"size"] = @(10);
    par[@"telephone"] = [UserManager getUserObject].telephone;
    par[@"orderType"] = @(3);
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [AFNetPackage getJSONWithUrl:url parameters:par success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [self.orders removeAllObjects];
        }
        [self loadSuccessBlockWith:responseObject];
        [self.tableView reloadData];
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    [self.tableView.mj_footer resetNoMoreData];
}

-(void)loadMoreData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/orderList.php"];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"page"] = @(self.page);
    par[@"size"] = @(10);
    par[@"telephone"] = [UserManager getUserObject].telephone;
    par[@"orderType"] = @(3);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [AFNetPackage getJSONWithUrl:url parameters:par success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self loadSuccessBlockWith:responseObject];
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    [self.tableView.mj_footer resetNoMoreData];
}

-(void)loadSuccessBlockWith:(id)responseObject{
    self.page = self.page + 1;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    if ([dic[@"code"] integerValue] == 200) {
        [self.tableView.mj_header endRefreshing];
        
        NSMutableArray *datas = dic[@"data"];
        for (NSDictionary *dic in datas) {
            [self.orders addObject:[OrderModel yy_modelWithJSON:dic]];
        }
        
        self.tableView.mj_footer.hidden = NO;
        if (datas.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }else{
        [SVProgressHUD showErrorWithStatus:dic[@"message"]];
    }
}

#pragma mark - UITableViewDeegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LBPLog(@"点击了");
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.orders.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
    cell.delegate = self;
    cell.type = self.type;
    cell.model = self.orders[indexPath.row];
    return cell;
}


#pragma mark - OrderCellDelegte
-(void)orderCell:(OrderCell *)cell didClickButtonWithCellType:(OrderButtonOperationType)type withOrderModel:(OrderModel *)model{
    switch (type) {
        case OrderButtonOperationType_Pay:{
            LBPLog(@"支付订单");
            break;
        }
        case OrderButtonOperationType_Cancel:{
            LBPLog(@"删除订单");
            break;
        }
        case OrderButtonOperationType_Revoke:{
            LBPLog(@"取消订单");
            break;
        }
        case OrderButtonOperationType_Evaluate:{
            LBPLog(@"评价订单");
            break;
        }
        case OrderButtonOperationType_Remind:{
            LBPLog(@"添加提醒");
            break;
        }
        case OrderButtonOperationType_ReBook:{
            LBPLog(@"再次预定");
            break;
        }
    }
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight-64-49) style:UITableViewStylePlain];
        tb.delegate = self;
        tb.dataSource = self;
        tb.contentInset = UIEdgeInsetsMake(0, 0, [ProjectUtil isPhoneX]?49+41:49, 0);
        tb.backgroundColor = TableViewBackgroundColor;
        tb.tableFooterView = [[UIView alloc] init];
        tb.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [tb registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:OrderCellId];
        __weak typeof(self) Weakself = self;
        tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            Weakself.page = 1;
            [Weakself reloadData];
        }];
        
        tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [Weakself loadMoreData];
        }];
        tb.mj_header.automaticallyChangeAlpha = YES;
        
        _tableView = tb;
    }
    return _tableView;
}

-(NSMutableArray *)orders{
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
    return _orders;
}
@end
