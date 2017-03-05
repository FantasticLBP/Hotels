
//
//  SearchResultVC.m
//  住哪儿
//
//  Created by geek on 2017/3/5.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "SearchResultVC.h"
#import "HotelDescriptionCell.h"
#import "HotelDetailVC.h"

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";
@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *hotels;                   /**<酒店数据*/

@end

@implementation SearchResultVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self preData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)loadMoreHotel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/Hotels_Server/controller/api/hotelLIst.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"telephone"] = [UserManager getUserObject].telephone;
    paras[@"cityName"] = self.searchConditions[@"cityName"];
    paras[@"pickedHotelName"] = self.searchConditions[@"pickedHotelName"];
    paras[@"pickedPrice"] = self.searchConditions[@"pickedPrice"];
    paras[@"pickedStar"] = self.searchConditions[@"pickedStar"];
    paras[@"request"] = @(5);
    
    paras[@"page"] = @(1);
    paras[@"size"] = @(10);
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
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/Hotels_Server/controller/api/hotelLIst.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"telephone"] = [UserManager getUserObject].telephone;
    paras[@"cityName"] = self.searchConditions[@"cityName"];
    paras[@"pickedHotelName"] = self.searchConditions[@"pickedHotelName"];
    paras[@"pickedPrice"] = self.searchConditions[@"pickedPrice"];
    paras[@"pickedStar"] = self.searchConditions[@"pickedStar"];
    paras[@"page"] = @(self.page);
    paras[@"size"] = @(10);
    paras[@"request"] = @(5);
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
    NSMutableArray *datas = [NSMutableArray array];
    datas =  dic[@"data"];
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
    return self.hotels.count ;
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
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark --lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        
        _tableView.tableFooterView = ({
            UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 80)];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(BoundWidth/2-70, 20, 140, 40);
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 3;
            button.layer.borderColor = GlobalMainColor.CGColor;
            [button setTitle:@"重新查找" forState:UIControlStateNormal];
            [button setTitleColor:GlobalMainColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(loadMoreHotel) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            view;
        });
        
        __weak typeof(self) Weakself = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [Weakself preData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [Weakself loadMoreData];
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        
        
    }
    return _tableView;
}

-(NSMutableArray *)hotels{
    if (!_hotels) {
        _hotels = [NSMutableArray array];
    }
    return _hotels;
}


@end
