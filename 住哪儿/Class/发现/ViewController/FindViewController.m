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
#import "JFCityViewController.h"
#import "SpecialHotelsCell.h"


#import "HotelsModel.h"

#define HeaderImageHeight 200
#define FindDownImageWIdth 16

static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";
static NSString *TopicHotelCellID = @"TopicHotelCell";
static NSString *SpecialHotelsCellID = @"SpecialHotelsCell";

@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate,
                                SDCycleScrollViewDelegate,
                                TopicHotelCellDelegate>
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *hotels;                   /**<酒店数据*/
@property (nonatomic, strong) NSMutableArray *subjects;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIButton *topButton;
@end

@implementation FindViewController

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.cityName = [ProjectUtil getCityName];
    [self loadSubjectImage];
    [self preData];
    [self loadSubject];
    [self setupUI];
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
    [self updateLeftBarButtonItem];
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

-(void)filterHotel{
    FilterHotelVC *vc = [[FilterHotelVC alloc] init];
    vc.cityName = self.cityName;
    vc.topic = ^(NSString *type){
        TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
        vc.type = type;
        vc.cityName = self.cityName;
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
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)backTop{
    [self.tableView setContentOffset:CGPointMake(0,-HeaderImageHeight) animated:NO];
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/Hotels_Server/controller/api/hotelLIst.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"telephone"] = [UserManager getUserObject].telephone;
    paras[@"cityName"] = self.cityName;
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
    paras[@"cityName"] = self.cityName;
    paras[@"page"] = @(self.page);
    paras[@"size"] = @(10);
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
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/Hotels_Server/controller/api/subject.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"telephone"] = [UserManager getUserObject].telephone;
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
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/Hotels_Server/controller/api/WeclomeImage.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"telephone"] = [UserManager getUserObject].telephone;
    para[@"size"] = @"5";
    [SVProgressHUD showWithStatus:@"正在获取图片"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray *array = dic[@"data"];
            for (NSDictionary *dic in array) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/Hotels_Server/",dic[@"image"]]];
            }
            self.advertiseView.imageURLStringsGroup = self.images;
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - TopicHotelCellDelegate
-(void)topicHotelCell:(TopicHotelCell *)topicHotelCell didSelectAtIndex:(NSInteger)index{
    TopicHotelListVCViewController *vc = [[TopicHotelListVCViewController alloc] init];
    vc.type = [NSString stringWithFormat:@"%zd",index];
    vc.cityName = self.cityName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotels.count + 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 223;
    }else if(indexPath.row >=1 && indexPath.row <= self.hotels.count){
        return 270;
    }else{
        return 200;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopicHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicHotelCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.subjects = self.subjects;
        return cell;
    }else if(indexPath.row >=1 && indexPath.row <= self.hotels.count){
        HotelDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelDescriptionCellID forIndexPath:indexPath];
        cell.model = self.hotels[indexPath.row-1];
        return cell;
    }else{
        SpecialHotelsCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialHotelsCellID forIndexPath:indexPath];
        cell.name = @"测试。刘斌鹏";
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
    if (scrollView.contentOffset.y > (BoundHeight - 64 -50 -45)) {
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
