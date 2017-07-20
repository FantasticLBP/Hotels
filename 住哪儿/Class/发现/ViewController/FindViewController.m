//
//  FindViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/10/10.
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
#import "JFCityViewController.h"
#import "SpecialHotelsCell.h"
#import "SpecialHotelFlagCell.h"
#import "HotelsModel.h"


#import "LocationManager.h"

#define HeaderImageHeight 200
#define FindDownImageWIdth 16

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";
static NSString *TopicHotelCellID = @"TopicHotelCell";
static NSString *SpecialHotelsCellID = @"SpecialHotelsCell";
static NSString *SpecialHotelFlagCellID = @"SpecialHotelFlagCell";

@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,
                                SDCycleScrollViewDelegate,
                                TopicHotelCellDelegate,
                                LocationManagerDelegate>
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *hotels;                   //酒店数据
@property (nonatomic, strong) NSMutableArray *subjects;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, assign) BOOL isPickedCity;                        //是否是用户自己选择的城市
@end

@implementation FindViewController

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadSubjectImage];
    [self preData];
    [self loadSubject];
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isPickedCity) {
        [self autoLocate];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"发现";
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.title = @"筛选";
        right.target = self;
        right.action = @selector(filterHotel);
        right;
    });
    self.page = 1;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.advertiseView];
}

-(void)updateLeftBarButtonItem{
    if ([ProjectUtil isBlank:self.cityName]) {
        self.cityName = @"北京";
    }
    self.navigationItem.leftBarButtonItem = ({
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = [UIImage imageNamed:@"Find_down"];
        [self.leftButton setImage:buttonImage forState:UIControlStateNormal];
        [self.leftButton setTitle:self.cityName forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, [ProjectUtil measureLabelWidth:self.cityName withFontSize:17], 0,0)];
        [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -FindDownImageWIdth, 0, FindDownImageWIdth)];
        [self.leftButton addTarget:self action:@selector(pickCity) forControlEvents:UIControlEventTouchUpInside];
        CGSize buttonTitleLabelSize = [self.cityName sizeWithAttributes:@{NSFontAttributeName:self.leftButton.titleLabel.font}]; //文本尺寸
        CGSize buttonImageSize = buttonImage.size;   //图片尺寸
        self.leftButton.frame = CGRectMake(0,0,
                                           buttonImageSize.width + buttonTitleLabelSize.width,
                                           buttonImageSize.height);
        
        UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
        leftBarButtomItem;
    });
}

-(void)autoLocate{
    self.locationManager = [LocationManager sharedInstance];
    self.locationManager.delegate =  self;
    [self.locationManager autoLocate];
}

-(void)filterHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.cityName = self.cityName;
    vc.topic = ^(NSString *subjectType,NSString *subjectName){
        TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
        vc.type = subjectType;
        vc.cityName = self.cityName;
        vc.title = subjectName;
        [self.navigationController pushViewController:vc animated:YES];
    };
    LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)pickCity{
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        weakSelf.cityName = cityName;
        [ProjectUtil saveCityName:cityName];
        [weakSelf updateLeftBarButtonItem];
        [self preData];
    }];
    LBPNavigationController *navigationController = [[LBPNavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:^{
        self.isPickedCity = YES;
    }];
}

-(void)backTop{
    [self.tableView setContentOffset:CGPointMake(0,-HeaderImageHeight) animated:NO];
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/hotelList.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"cityName"] = self.cityName;
    paras[@"type"] = @(3);
    paras[@"page"] = @(1);
    paras[@"size"] = @(10);
    paras[@"request"] = @(3);
    
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
    paras[@"cityName"] = self.cityName;
    paras[@"type"] = @(3);
    paras[@"page"] = @(self.page);
    paras[@"size"] = @(10);
    paras[@"request"] = @(3);
    
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

-(void)loadSubject{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/subject.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"key"] = AppKey;
    [SVProgressHUD showWithStatus:@"正在获取主题列表"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.subjects = dic[@"data"];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}

//获取轮播图
-(void)loadSubjectImage{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/WeclomeImage.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"key"] = AppKey;
    para[@"size"] = @"5";
    [SVProgressHUD showWithStatus:@"正在获取图片"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray *array = dic[@"data"];
            for (NSDictionary *dic in array) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",dic[@"image"]]];
            }
            self.advertiseView.imageURLStringsGroup = self.images;
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - LocationManagerDelegate
-(void)locationManager:(LocationManager *)locationManager didGotLocation:(NSString *)location{
    self.cityName = location;
    [self updateLeftBarButtonItem];
}

#pragma mark - TopicHotelCellDelegate
-(void)topicHotelCell:(TopicHotelCell *)topicHotelCell didSelectAtIndex:(NSInteger)index andSubjectName:(NSString *)subjectName{
    TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
    vc.type = [NSString stringWithFormat:@"%zd",index];
    vc.cityName = self.cityName;
    vc.title = subjectName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotels.count + 6+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 223;
    }else if(indexPath.row == 1){
        return 60;
    }else if(indexPath.row >=2 && indexPath.row < self.hotels.count+2){
        return 270;
    }else{
        return 200;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopicHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicHotelCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.subjects = self.subjects;
        return cell;
    }else if(indexPath.row == 1){
        SpecialHotelFlagCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialHotelFlagCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row >=2 && indexPath.row < self.hotels.count+2){
        HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
        cell.model = self.hotels[indexPath.row-2];
        return cell;
    }else{
        SpecialHotelsCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialHotelsCellID forIndexPath:indexPath];
        cell.name = @"烟雨千岛湖 私享避世小假日";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>= 2 + self.hotels.count ) {
        [SVProgressHUD showInfoWithStatus:@"此处要加入HTML5网页，等待程序员哥哥后续升级哦"];
    }else if (indexPath.row >1 && indexPath.row < self.hotels.count + 2){
        HotelDetailVC *vc = [[HotelDetailVC alloc] init];
        vc.startPeriod = [[NSDate date] todayString];
        vc.leavePerios = [[NSDate date] GetTomorrowDayString];
        vc.model = self.hotels[indexPath.row-2];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (scrollView.contentOffset.y > BoundHeight-HeaderImageHeight-64-50) {
        [self.view addSubview:self.topButton];
    }else{
        [self.topButton removeFromSuperview];
    }
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
         [_tableView registerNib:[UINib nibWithNibName:@"SpecialHotelsCell" bundle:nil] forCellReuseIdentifier:SpecialHotelsCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SpecialHotelFlagCell" bundle:nil] forCellReuseIdentifier:SpecialHotelFlagCellID];
        _tableView.contentInset = UIEdgeInsetsMake(HeaderImageHeight, 0, 50, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        __weak typeof(self) WeakSelf = self;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [WeakSelf loadMoreData];
        }];
        _tableView.mj_footer.hidden = YES;
        
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

-(NSMutableArray *)hotels{
    if (!_hotels) {
        _hotels = [NSMutableArray array];
    }
    return _hotels;
}

-(NSMutableArray *)subjects{
    if (!_subjects) {
        _subjects = [NSMutableArray array];
    }
    return _subjects;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

-(UIButton *)topButton{
    if(!_topButton){
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton setBackgroundImage:[UIImage imageNamed:@"Find_BackTop"] forState:UIControlStateNormal];
        _topButton.frame = CGRectMake(BoundWidth-60, BoundHeight-45-64-50, 45, 45);
        [_topButton addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}

@end
