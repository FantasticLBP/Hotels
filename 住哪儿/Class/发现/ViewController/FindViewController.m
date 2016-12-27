//
//  FindViewController.m
//  住哪儿
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "FindViewController.h"
#import "HotelDescriptionCell.h"
#import "HotelDetailVC.h"
#import "SDCycleScrollView.h"
#import "TopicHotelCell.h"
#import "TopicHotelListVCViewController.h"
#import "FilterHotelVC.h"
#import "LBPNavigationController.h"

#define HeaderImageHeight 200

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";
static NSString *TopicHotelCellID = @"TopicHotelCell";

@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,
                                SDCycleScrollViewDelegate,
                                TopicHotelCellDelegate>
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"发现•有特色的酒店";
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.title = @"筛选";
        right.target = self;
        right.action = @selector(filterHotel);
        right;
    });
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.advertiseView];
    for (int i = 1; i <= 5; i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"jpg-%d",i]];
    }
    self.advertiseView.localizationImageNamesGroup = self.dataArray;
    
}

-(void)filterHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.topic = ^(NSString *type){
        NSLog(@"选择了%@",type);
        TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - TopicHotelCellDelegate
-(void)topicHotelCell:(TopicHotelCell *)topicHotelCell didSelectAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 223;
    }else{
        return 270;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopicHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicHotelCellID forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelDetailVC *vc = [[HotelDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.y < 0) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
}


#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        [_tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TopicHotelCell" bundle:nil] forCellReuseIdentifier:TopicHotelCellID];
        _tableView.contentInset = UIEdgeInsetsMake(HeaderImageHeight, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(SDCycleScrollView *)advertiseView{
    if (!_advertiseView) {
        SDCycleScrollView *adview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BoundWidth, HeaderImageHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        adview.currentPageDotColor = [UIColor whiteColor];
        adview.originY = 170;
        adview.tag = 101;
        adview.mode = UIViewContentModeScaleAspectFill;
        _advertiseView = adview;
    }
    return _advertiseView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
