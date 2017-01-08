

//
//  OrderResultViewControllrt.m
//  住哪儿
//
//  Created by geek on 2017/1/6.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderResultViewController.h"
#import "OrderCompletedFirstCell.h"
#import "OrderInfoCell.h"

static NSString *OrderCompletedFirstCellID= @"OrderCompletedFirstCell";
static NSString *OrderInfoCellID = @"OrderInfoCell";

@interface OrderResultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderResultViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"订单完成";
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDeegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else{
        return 125;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OrderCompletedFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCompletedFirstCellID];
        return cell;
    }else{
        OrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCellID forIndexPath:indexPath];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  100;
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
        [tb registerClass:[OrderCompletedFirstCell class] forCellReuseIdentifier:OrderCompletedFirstCellID];
        [tb registerClass:[OrderInfoCell class] forCellReuseIdentifier:OrderInfoCellID];
        _tableView = tb;
    }
    return _tableView;
}

@end
