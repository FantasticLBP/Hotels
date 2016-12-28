


//
//  TopicHotelListVCViewController.m
//  住哪儿
//
//  Created by geek on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelListVCViewController.h"
#import "LBPNavigationController.h"
#import "FilterHotelVC.h"
#import "HotelDescriptionCell.h"

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";


@interface TopicHotelListVCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation TopicHotelListVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"精品民宿";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.title = @"切换主题";
        right.target = self;
        right.action = @selector(filterTheHotel);
        right;
    });
    [self.view addSubview:self.tableView];
    [self preData];
}

#pragma mark -- private method
- (void)preData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    for (int i = 1; i <= 8; i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"jpg-%d",i]];
    }
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    self.tableView.mj_footer.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView reloadData];
}



-(void)filterTheHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.topic = ^(NSString *type){
        NSLog(@"选择了%@",type);
        NSLog(@"等待刷新列表");
    };
    
    LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
    cell.hotelImageName = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}


#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        __weak typeof(self) WeakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [WeakSelf preData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [WeakSelf preData];
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;       // 设置自动切换透明度(在导航栏下面自动隐藏)
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
