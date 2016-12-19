
//
//  HomeViewController.m
//  酒店达人
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchHotelVC.h"
#import "SDCycleScrollView.h"
#import "SelectConditionCell.h"
#import "HotPopularHotelAdCell.h"
#import "SpecialHotelCell.h"
#import "HotelDescriptionCell.h"
#import "TrainBookingVC.h"
#import "ConditionPickerView.h"

#import "YYFPSLabel.h"

static NSString *SelectConditionCellID = @"SelectConditionCell";
static NSString *HotPopularHotelAdCellID = @"HotPopularHotelAdCell";
static NSString *SpecialHotelCellID = @"SpecialHotelCell";
static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";

@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SelectConditionCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) NSMutableArray *condtions;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@property (nonatomic, strong) ConditionPickerView *conditionView;
@property (nonatomic, strong) UIView *headerView;


@end

@implementation HomeViewController

#pragma mark -- life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preData];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    [self testFPSLabel];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [SVProgressHUD dismiss];
}

- (UIStatusBarStyle)preferredStatusBarStyle {   //设置样式
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden { //设置隐藏显示
    return YES;
}

- (void)preData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    for (int i = 1; i <= 11; i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"jpg-%d",i]];
    }
    self.advertiseView.localizationImageNamesGroup = self.dataArray;
    [SVProgressHUD dismiss];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    self.tableView.mj_footer.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView reloadData];
}

- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(BoundWidth/2-25, 20, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - SelectConditionCellDelegate
-(void)selectConditionCell:(SelectConditionCell *)selectConditionCell didClickCollectionCellAtIndexPath:(NSInteger)indexPath{
    if (indexPath == 0) {
        NSString *docDir=[[NSBundle mainBundle]bundlePath];
        NSString *pathurl=[docDir stringByAppendingPathComponent:@"blank.html"];
        TrainBookingVC *vc = [[TrainBookingVC alloc] init];
        vc.path = pathurl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 181;
    }else if(indexPath.row == 1){
        return 106;
    }else if (indexPath.row == 2){
        return 81;
    }else{
        return 270;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SelectConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectConditionCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.datas = self.condtions;
        return cell;
    }else if (indexPath.row == 1){
        HotPopularHotelAdCell *cell = [tableView dequeueReusableCellWithIdentifier:HotPopularHotelAdCellID forIndexPath:indexPath];
        cell.datas = self.condtions;
        return cell;
    }else if (indexPath.row == 2){
        SpecialHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialHotelCellID forIndexPath:indexPath];
        return cell;
    }else{
        HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
        cell.hotelImageName = self.dataArray[indexPath.row - 3];
        return cell;
    }
}

#pragma mark -- private method
-(void)remind{
    NSLog(@"remind");
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
        [_tableView registerClass:[SelectConditionCell class] forCellReuseIdentifier:SelectConditionCellID];
        [_tableView registerClass:[HotPopularHotelAdCell class] forCellReuseIdentifier:HotPopularHotelAdCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SpecialHotelCell" bundle:nil] forCellReuseIdentifier:SpecialHotelCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        
        __weak typeof(self) WeakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [WeakSelf preData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [WeakSelf preData];
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;       // 设置自动切换透明度(在导航栏下面自动隐藏)
        _tableView.allowsSelection=NO;
    }
    return _tableView;
}

-(SDCycleScrollView *)advertiseView{
    if (!_advertiseView) {
        SDCycleScrollView *adview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BoundWidth, 394) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        adview.currentPageDotColor = [UIColor whiteColor];
        _advertiseView = adview;
    }
    return _advertiseView;
}

-(ConditionPickerView *)conditionView{
    if (!_conditionView) {
        _conditionView = [[ConditionPickerView alloc] initWithFrame:CGRectMake(10, 130, BoundWidth-20, 255)];
    }
    return _conditionView;
}

-(UIView *)headerView{
    if (!_headerView) {
        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 394)];
        head.backgroundColor = [UIColor whiteColor];
        [head addSubview:self.advertiseView];
        [head addSubview:self.conditionView];
        _headerView = head;
    }
    return _headerView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)condtions{
    if (!_condtions) {
        NSMutableArray *datas = [NSMutableArray array];
        NSArray *images =  @[@"Home_appoinement",@"Home_health",@"Home_interactivePlatform",@"Home_advisory Complaints",
                             @"Home_dietDocument",@"Home_stepCounter",@"Home_BMIDocument",@"Home_myNotice"];
        NSArray *titles = @[@"预约挂号",@"健康资讯",@"互动平台",@"咨询投诉",
                            @"饮食档案",@"计步档案",@"BMI档案",@"我的提醒"];
        
        for (int i=0; i<images.count; i++) {
            NSDictionary *dic = @{@"image":images[i],@"title":titles[i]};
            [datas addObject:dic];
        }
        _condtions = datas;
    }
    return _condtions;
}

@end
