//
//  OrderViewController.m
//  住哪儿
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "OrderViewController.h"

static NSString *OrderCellId = @"OrderCell";
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orders;           /**<订单数据源*/
@property (nonatomic, assign) NSInteger page;                          /**<页码*/

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
        item.image = [UIImage imageNamed:@"small_icon_phone"];
        item.target = self;
        item.action = @selector(clickContactPhone);
         item;
    });
    
    [self.view addSubview:self.tableView];
    self.page  = 1;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)clickContactPhone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打客服电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *tel = [UIAlertAction actionWithTitle:TelePhoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * telUrl = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",TelePhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }];
    [alert addAction:tel];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

-(void)reloadData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"api/orderList"];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"page"] = @(self.page);
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [AFNetPackage getJSONWithUrl:url parameters:par success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"status"] integerValue] == 200) {
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
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"api/orderList"];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"page"] = @(self.page);
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
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    if ([dic[@"status"] integerValue] == 200) {
        NSArray *datas = dic[@"data"];
        
        
    
        [self.tableView.mj_header endRefreshing];
        NSMutableArray *data = dic[@"data"];
        if (true) {
            self.page += 1;
        }else{
            self.page = 1;
        }
        
        
        if (datas.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        
      self.tableView.mj_footer.hidden = NO;
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }else{
        [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
    }
}
#pragma mark - UITableViewDeegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.orders.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OrderCellId];
    }
    return cell;
}


#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStylePlain];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        tb.tableFooterView = [[UIView alloc] init];
        tb.separatorStyle  = UITableViewCellSeparatorStyleNone;
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
@end
