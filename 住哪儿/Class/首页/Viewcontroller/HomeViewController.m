
//
//  HomeViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchHotelVC.h"
#import "SDCycleScrollView.h"
#import "SelectConditionCell.h"
#import "HotPopularHotelAdCell.h"
#import "SpecialHotelCell.h"
#import "HotelDescriptionCell.h"
#import "ConditionPickerView.h"
#import "HotelDetailVC.h"
#import "SalePromotionImageView.h"
#import "PrivilegeHotelVC.h"
#import "TimerPickerVC.h"
#import "LBPNavigationController.h"
#import "JFCityViewController.h"
#import "PriceAndStarLevelPickerView.h"
#import "MainViewController.h"
#import "SearchResultVC.h"
#import "LocationManager.h"

#define SalePromotionImageWidth 49
#define SalePromotionImageHeight 54
static NSString *SelectConditionCellID = @"SelectConditionCell";
static NSString *HotPopularHotelAdCellID = @"HotPopularHotelAdCell";
static NSString *SpecialHotelCellID = @"SpecialHotelCell";
static NSString *HotelDescriptionCellID = @"HotelDescriptionCell";

@interface HomeViewController ()<SDCycleScrollViewDelegate,
                                UITableViewDelegate,UITableViewDataSource,SelectConditionCellDelegate,SalePromotionImageViewDelegate,
                                    ConditionPickerViewDelegate,
                                    PriceAndStarLevelPickerViewDelegate,
                                    TimerPickerVCDelegate,LocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *advertiseView;
@property (nonatomic, strong) SalePromotionImageView *saleImageView;
@property (nonatomic, strong) PriceAndStarLevelPickerView *starView;
@property (nonatomic, strong) ConditionPickerView *conditionView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) LocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray *condtions;
@property (nonatomic, strong) NSMutableDictionary *conditionDic;
@property (nonatomic, strong) NSMutableArray *subjectImages;
@property (nonatomic, strong) NSMutableArray *hotels;                   /**<酒店数据*/
@property (nonatomic, strong) NSString *city;                           //定位城市
@property (nonatomic, assign) BOOL isPickedCity;                        //是否是用户自己选择的城市
@end

@implementation HomeViewController

#pragma mark -- life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     if (!kDevice_Is_iPhoneX) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
     }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saleImageView];
    [self loadSubjectImage];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isPickedCity) {
        [self autoLocate];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!kDevice_Is_iPhoneX) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [SVProgressHUD dismiss];
}

- (BOOL)prefersStatusBarHidden { //设置隐藏显示
    if (kDevice_Is_iPhoneX) {
        return NO;
    }
    return YES;
}

#pragma mark - private method

-(void)searchHotelWithCondition{
    SearchResultVC *vc = [[SearchResultVC alloc] init];
    NSMutableDictionary *dic = self.conditionDic;
    NSString *pickedLevel = self.conditionDic[@"pickedLevel"];
    if ([ProjectUtil isBlank:self.conditionDic[@"cityName"]]) {
        [ProjectUtil saveCityName:[ProjectUtil isBlank:[ProjectUtil getCityName]]?@"北京":[ProjectUtil getCityName]];
    }else{
         [ProjectUtil saveCityName:self.conditionDic[@"cityName"]];
    }
    dic[@"cityName"] = [ProjectUtil getCityName];
    NSArray *array = [pickedLevel componentsSeparatedByString:@"，"];
    if (array.count > 1) {
        [dic setObject:array[0] forKey:@"pickedStar"];
        [dic setObject:array[1] forKey:@"pickedPrice"];
    }
    vc.searchConditions = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

//获取轮播图
-(void)loadSubjectImage{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/WeclomeImage.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"key"] = AppKey;
    para[@"size"] = @"10";
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray *array = dic[@"data"];
            for (NSDictionary *dic in array) {
                [self.subjectImages addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",dic[@"image"]]];
            }
            self.advertiseView.imageURLStringsGroup = self.subjectImages;
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
    
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/hotelList.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"type"] = @(3);
    paras[@"page"] = @(1);
    paras[@"size"] = @(4);
    paras[@"request"] = @(3);
    paras[@"cityName"] = self.city;

    [SVProgressHUD showWithStatus:@"正在获取酒店数据"];
    
    [AFNetPackage getJSONWithUrl:url parameters:paras success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [self.hotels removeAllObjects];
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSMutableArray *datas = dic[@"data"];
            for (NSDictionary *dic in datas) {
                [self.hotels addObject:[HotelsModel yy_modelWithJSON:dic]];
            }
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}


// UITabBarController切换显示
-(void)loadMoreHotel{
    MainViewController *vc = (MainViewController *)[UIApplication sharedApplication] .keyWindow.rootViewController;
    vc.selectedIndex = 1;
}

//自动定位
-(void)autoLocate{
    self.locationManager = [LocationManager sharedInstance];
    self.locationManager.delegate = self;
    [self.locationManager autoLocate];
}

#pragma mark - LocationManagerDelegate
-(void)locationManager:(LocationManager *)locationManager didGotLocation:(NSString *)location{
    self.conditionView.cityName = location;
    self.city = location;
    [self preData];
}

#pragma mark - PriceAndStarLevelPickerViewDelegate
-(void)priceAndStarLevelPickerView:(PriceAndStarLevelPickerView *)view didClickWithhButtonType:(PriceAndStarLevel_Operation)type withData:(NSMutableDictionary *)data{
    switch (type) {
        case PriceAndStarLevel_Operation_clearCondition:{
            [view refreshUI];
            break;
        }
        case PriceAndStarLevel_Operation_OK:{
            self.conditionView.datas = data;
            [self.starView removeFromSuperview];
            break;
        }
        default:
            break;
    }
}

#pragma mark - TimerPickerVCDelegate
-(void)timerPickerVC:(TimerPickerVC *)vc didPickedTime:(NSDate *)period{
    self.conditionView.pickedEndTime = period;
}

#pragma mark - ConditionPickerViewDelegate
-(void)conditionPickerView:(ConditionPickerView *)view didClickWithActionType:(Operation_Type)type andPickedData:(NSMutableDictionary *)dic{
    self.conditionDic = dic;
    switch (type) {
        case Operation_Type_InTime:{
            TimerPickerVC *timePicker = [[TimerPickerVC alloc] init];
            timePicker.delegate = self;
            LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:timePicker];
            [self.navigationController presentViewController:navi animated:true completion:nil];
        }
        case Operation_Type_EndTime:{
            TimerPickerVC *timePicker = [[TimerPickerVC alloc] init];
            timePicker.delegate = self;
            LBPNavigationController *navi = [[LBPNavigationController alloc] initWithRootViewController:timePicker];
            [self.navigationController presentViewController:navi animated:true completion:nil];
        }
        case Operation_Type_Locate:{
            JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
            cityViewController.title = @"城市";
            [cityViewController choseCityBlock:^(NSString *cityName) {
                self.conditionView.cityName = cityName;
                self.city = cityName;
                [self preData];
            }];
            LBPNavigationController *navigationController = [[LBPNavigationController alloc] initWithRootViewController:cityViewController];
            [self presentViewController:navigationController animated:YES completion:^{
                self.isPickedCity = YES;
            }];
            break;
        }
        case Operation_Type_AutoLocate:{
            [self autoLocate];
            break;
        }
        case Operation_Type_SearchHotel:{
            [self searchHotelWithCondition];
            break;
        }
        case Operation_Type_StarFilter:{
            self.starView = [[PriceAndStarLevelPickerView alloc] initWithFrame:CGRectMake(0,BoundHeight, BoundWidth, 600)];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.starView];
            self.starView.delegate = self;
            break;
        }
            
        default:
            break;
    }
}
#pragma mark - SalePromotionImageViewDelegate
-(void)salePromotionImageView:(SalePromotionImageView *)salePromotionImageView didClickAtPromotionView:(NSString *)flag{
    PrivilegeHotelVC *vc = [[PrivilegeHotelVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    LBPLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - SelectConditionCellDelegate
-(void)selectConditionCell:(SelectConditionCell *)selectConditionCell didClickCollectionCellAtIndexPath:(NSInteger)indexPath{
    switch (indexPath) {
        case 0:{
            PrivilegeHotelVC *vc = [[PrivilegeHotelVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
            
        }
        case 2:
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
        case 3:{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case 4:
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
        case 5:
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
        case 6:
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
        case 7:
            [SVProgressHUD showInfoWithStatus:@"程序员哥哥正在努力哦，敬请期待！"];
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotels.count + 3;
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
        cell.model = self.hotels[indexPath.row-3];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>=3) {
        HotelDetailVC *vc = [[HotelDetailVC alloc] init];
        vc.startPeriod = [[NSDate date] todayString];
        vc.leavePerios = [[NSDate date] GetTomorrowDayString];
        vc.model = self.hotels[indexPath.row-3];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark --lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight - 49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor brownColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kDevice_Is_iPhoneX?34:0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SelectConditionCell class] forCellReuseIdentifier:SelectConditionCellID];
        [_tableView registerClass:[HotPopularHotelAdCell class] forCellReuseIdentifier:HotPopularHotelAdCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SpecialHotelCell" bundle:nil] forCellReuseIdentifier:SpecialHotelCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"HotelDescriptionCell" bundle:nil] forCellReuseIdentifier:HotelDescriptionCellID];
        
        _tableView.tableFooterView = ({
            UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 80)];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(BoundWidth/2-70, 20, 140, 40);
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 3;
            button.layer.borderColor = GlobalMainColor.CGColor;
            [button setTitle:@"发现更多" forState:UIControlStateNormal];
            [button setTitleColor:GlobalMainColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(loadMoreHotel) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            view;
        });
        
    }
    return _tableView;
}

-(SDCycleScrollView *)advertiseView{
    if (!_advertiseView) {
        SDCycleScrollView *adview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BoundWidth, 394) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        adview.currentPageDotColor = [UIColor whiteColor];
        adview.originY = 112;
        _advertiseView = adview;
    }
    return _advertiseView;
}

-(ConditionPickerView *)conditionView{
    if (!_conditionView) {
        _conditionView = [[ConditionPickerView alloc] initWithFrame:CGRectMake(10, 130, BoundWidth-20, 255)];
        _conditionView.delegate = self;
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

-(NSMutableArray *)condtions{
    if (!_condtions) {
        NSMutableArray *datas = [NSMutableArray array];
        NSArray *images =  @[@"Home_appoinement",@"Home_health",@"Home_interactivePlatform",@"Home_advisory Complaints",
                             @"Home_dietDocument",@"Home_stepCounter",@"Home_BMIDocument",@"Home_myNotice"];
        NSArray *titles = @[@"钟点房",@"门票",@"特惠酒店",@"当地",
                            @"机票",@"火车票",@"汽车票",@"特色酒店"];
        
        for (int i=0; i<images.count; i++) {
            NSDictionary *dic = @{@"image":images[i],@"title":titles[i]};
            [datas addObject:dic];
        }
        _condtions = datas;
    }
    return _condtions;
}

-(SalePromotionImageView *)saleImageView{
    if (!_saleImageView) {
        _saleImageView = [[SalePromotionImageView alloc] initWithFrame:CGRectMake(BoundWidth-SalePromotionImageWidth, BoundHeight/2-SalePromotionImageHeight/2, SalePromotionImageWidth, SalePromotionImageHeight)];
        _saleImageView.defaultImageName = @"Home_sale_promotion";
        _saleImageView.delegate = self;
    }
    return _saleImageView;
}

-(NSMutableDictionary *)conditionDic{
    if (!_conditionDic) {
        _conditionDic = [NSMutableDictionary dictionary];
    }
    return _conditionDic;
}

-(NSMutableArray *)subjectImages{
    if (!_subjectImages) {
        _subjectImages = [NSMutableArray array];
    }
    return _subjectImages;
}

-(NSMutableArray *)hotels{
    if (!_hotels) {
        _hotels = [NSMutableArray array];
    }
    return _hotels;
}

@end
