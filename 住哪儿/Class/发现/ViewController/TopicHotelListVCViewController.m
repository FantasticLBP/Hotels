
//
//  TopicHotelListVCViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelListVCViewController.h"
#import "LBPNavigationController.h"
#import "FilterHotelVC.h"
#import "HotelDescriptionCell.h"
#import "HotelDetailVC.h"

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";


@interface TopicHotelListVCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotels;
@property (nonatomic, assign) NSInteger page;
@end

@implementation TopicHotelListVCViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self preData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.title = @"切换主题";
        right.target = self;
        right.action = @selector(filterTheHotel);
        right;
    });
    self.page = 1;
    [self.view addSubview:self.tableView];
}

-(void)filterTheHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.cityName = self.cityName;
    vc.topic = ^(NSString *subjectType,NSString *subjectName){
        self.type = subjectType;
        vc.title = subjectName;
        [self preData];
    };
    LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/hotelList.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"subjectId"] = self.type;
    paras[@"cityName"] = self.cityName;
    paras[@"page"] = @(1);
    paras[@"size"] = @(10);
    paras[@"request"] = @(1);
    
    [SVProgressHUD showWithStatus:@"正在获取酒店数据"];
    
    [AFNetPackage getJSONWithUrl:url parameters:paras success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [self.hotels removeAllObjects];
            self.page = 1;
            [self loadSuccessBlockWith:responseObject];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    [self.tableView.mj_footer resetNoMoreData];
}

-(void)loadMoreData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/hotelList.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"subjectId"] = self.type;
    paras[@"cityName"] = self.cityName;
    paras[@"page"] = @(self.page);
    paras[@"size"] = @(10);
    paras[@"request"] = @(1);
    [SVProgressHUD showWithStatus:@"正在获取酒店数据"];
    
    [AFNetPackage getJSONWithUrl:url parameters:paras success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [self loadSuccessBlockWith:responseObject];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    [self.tableView.mj_footer resetNoMoreData];
}

-(void)loadSuccessBlockWith:(id)responseObject{
    self.page = self.page + 1;
    [SVProgressHUD dismiss];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *datas = dic[@"data"];
    [self.tableView.mj_header endRefreshing];
    if (datas.count == 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden = YES;
        return;
    }
    self.tableView.mj_footer.hidden = NO;
    for (NSDictionary *dic in datas) {
        [self.hotels addObject:[HotelsModel yy_modelWithJSON:dic]];
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
    cell.model = self.hotels[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelDetailVC *vc = [[HotelDetailVC alloc] init];
    vc.startPeriod = [[NSDate date] todayString];
    vc.leavePerios = [[NSDate date] GetTomorrowDayString];
    vc.model = self.hotels[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight - 64) style:UITableViewStylePlain];
        tableView.dataSource=self;
        tableView.delegate = self;
        tableView.scrollsToTop = YES;
        tableView.backgroundColor = TableViewBackgroundColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        __weak typeof(self) WeakSelf = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [WeakSelf preData];
        }];
        
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [WeakSelf loadMoreData];
        }];
        tableView.mj_footer.hidden = YES;
        _tableView = tableView;
    }
    return _tableView;
}

-(NSMutableArray *)hotels{
    if (!_hotels) {
        _hotels = [NSMutableArray array];
    }
    return  _hotels;
}

@end
