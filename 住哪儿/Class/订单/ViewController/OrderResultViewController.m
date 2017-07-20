

//
//  OrderResultViewControllrt.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/6.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "OrderResultViewController.h"
#import "OrderCompletedFirstCell.h"
#import "OrderInfoCell.h"
#import "OrderViewController.h"
#import "HomeViewController.h"
#import "MainViewController.h"

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

-(void)watchOrders{
    NSMutableArray *vcs = [NSMutableArray array];
    [vcs addObject:[[HomeViewController alloc] init]];
    self.navigationController.viewControllers = vcs;
    
    MainViewController *vc = (MainViewController *)[UIApplication sharedApplication] .keyWindow.rootViewController;
    vc.selectedIndex = 3;
}

#pragma mark - UITableViewDeegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 150;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LBPLog(@"点击了");
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        OrderCompletedFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCompletedFirstCellID];
        return cell;
    }else{
        OrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCellID forIndexPath:indexPath];
        cell.orderNumber = self.orderId;
        cell.hotelName = self.hotelmodel.hotelName;
        cell.roomType = self.model.type;
        cell.livingPeriods = [NSString stringWithFormat:@"%@-%@ 共%zd晚",self.startPeriod,[ProjectUtil isNotBlank:self.leavePerios]?[NSString stringWithFormat:@"%@月%@日",[self.leavePerios substringToIndex:2],[self.leavePerios substringFromIndex:3]]:@"", [[NSDate sharedInstance] calcDaysFromBegin:self.startPeriod end:self.leavePerios]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 12;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 180)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 1;
    button.layer.borderColor = GlobalMainColor.CGColor;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(40, 70, BoundWidth-80, 35);
    [button setTitle:@"查看订单" forState:UIControlStateNormal];
    [button setTitleColor:GlobalMainColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(watchOrders) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 180;
    }else{
        return 0;
    }
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStylePlain];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        tb.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [tb registerClass:[OrderCompletedFirstCell class] forCellReuseIdentifier:OrderCompletedFirstCellID];
        [tb registerClass:[OrderInfoCell class] forCellReuseIdentifier:OrderInfoCellID];
        _tableView = tb;
    }
    return _tableView;
}

@end
