
//
//  HotelLocationMapVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/25.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelLocationMapVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>         //百度地图基本头文件
#import <BaiduMapAPI_Location/BMKLocationService.h> //百度地图定位头文件
#import <BaiduMapAPI_Search/BMKPoiSearch.h>         //百度地图搜索头文件
#import <MapKit/MapKit.h>                           //打开系统地图所需的头文件

@interface HotelLocationMapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic, strong) UIButton *myLodactionButton;      //我的位置按钮
@property (nonatomic, strong) UIButton *hotelLocationButton;    //酒店位置按钮
@property (nonatomic, strong) UIButton *navigationButton;       //开始导航按钮
@property (nonatomic, strong) BMKMapView *mapView;              //地图基本
@property (nonatomic, strong) BMKLocationService *locService;   //定位服务
@property (nonatomic, strong) BMKPoiSearch *poiSearch;          //搜索服务
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;  // 要导航的坐标
@end

@implementation HotelLocationMapVC

#pragma mark - lice cyele
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    self.mapView.delegate = nil;
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"酒店位置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    [self.locService startUserLocationService];
    
    [self.view addSubview:self.navigationButton];
    [self.view addSubview:self.myLodactionButton];
    [self.view addSubview:self.hotelLocationButton];
}

-(void)startNavigation{
    LBPLog(@"开始导航");
    [self presentViewController:self.alertController animated:YES completion:nil];
}

-(void)myPosition{
    LBPLog(@"我的位置");
}

-(void)hotelPosition{
    LBPLog(@"酒店位置");
    
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    self.mapView.showsUserLocation = YES;
    [self.mapView updateLocationData:userLocation];
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    self.mapView.zoomLevel = 18;
    
    //周边云检索参数信息类
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];;
    
    option.pageIndex = 0;
    option.pageCapacity = 50;
    option.location = userLocation.location.coordinate;
    option.keyword = self.destination;
    
    BOOL flag = [self.poiSearch poiSearchNearBy:option];
    if (flag) {
        LBPLog(@"搜索成功");
        [self.locService stopUserLocationService];
    }else{
        LBPLog(@"搜索失败");
    }
    
}

#pragma mark - BMKPoiSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        
        //只将搜索到的第一个点显示到界面上
        BMKPoiInfo *info = poiResult.poiInfoList.firstObject;
        //初始化一个点的注释
        BMKPointAnnotation *annotoation = [[BMKPointAnnotation alloc] init];
        self.coordinate = CLLocationCoordinate2DMake(info.pt.latitude, info.pt.longitude);
        annotoation.coordinate = info.pt;
        annotoation.title = info.name;
        annotoation.subtitle = self.destination;
        annotoation.subtitle = info.address;
        [self.mapView addAnnotation:annotoation];
        [self.mapView selectAnnotation:annotoation animated:YES];
        
        /*
         *将搜索到的所有结果显示出来
        for (BMKPoiInfo *info in poiResult.poiInfoList) {
            [self.dataArray addObject:info];
            
            //初始化一个点的注释
            BMKPointAnnotation *annotoation = [[BMKPointAnnotation alloc] init];
            annotoation.coordinate = info.pt;
            annotoation.title = info.name;
            annotoation.subtitle = self.destination;
            annotoation.subtitle = info.address;
            [self.mapView addAnnotation:annotoation];
            [self.mapView selectAnnotation:annotoation animated:YES];
        }
         */
    }
}

- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode{
    LBPLog(@"详情%@",poiDetailResult.name);
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        newAnnotation.pinColor = BMKPinAnnotationColorRed;
        newAnnotation.animatesDrop = YES;
        return newAnnotation;
    }
    return  nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    //poi详情检索信息类
    BMKPoiDetailSearchOption *option = [[BMKPoiDetailSearchOption alloc] init];
    
    BMKPoiInfo *info = self.dataArray.firstObject;
    
    //poi的uid，从poi检索返回的BMKPoiResult结构中获取
    option.poiUid = info.uid;
    
    BOOL flag = [self.poiSearch poiDetailSearch:option];
    
    if (flag) {
        LBPLog(@"检索成功");
    }
    else {
        LBPLog(@"检索失败");
    }
}

#pragma mark - lazy load
-(BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight)];
        _mapView.showsUserLocation = YES;
        _mapView.showIndoorMapPoi = YES;
        _mapView.zoomLevel = 21;
        _mapView.rotateEnabled = NO;
        _mapView.delegate = self;
    }
    return _mapView;
}

-(BMKLocationService *)locService{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return _locService;
}

-(BMKPoiSearch *)poiSearch{
    if (!_poiSearch) {
        _poiSearch = [[BMKPoiSearch alloc] init];
        _poiSearch.delegate = self;
    }
    return _poiSearch;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UIButton *)navigationButton{
    if (!_navigationButton) {
        _navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navigationButton.frame = CGRectMake(BoundWidth-120, BoundHeight-64-140, 100, 30);
        [_navigationButton setTitle:@"开始导航" forState:UIControlStateNormal];
        ;_navigationButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_navigationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _navigationButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _navigationButton.layer.cornerRadius = 5;
        [_navigationButton clipsToBounds];
        [_navigationButton addTarget:self action:@selector(startNavigation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationButton;
}

-(UIButton *)myLodactionButton{
    if (!_myLodactionButton) {
        _myLodactionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myLodactionButton.frame = CGRectMake(BoundWidth-120, BoundHeight-64-100, 100, 30);
        [_myLodactionButton setTitle:@"我的位置" forState:UIControlStateNormal];
        _myLodactionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_myLodactionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _myLodactionButton.backgroundColor = [UIColor whiteColor];
        _myLodactionButton.layer.cornerRadius = 5;
        [_myLodactionButton clipsToBounds];
        [_myLodactionButton addTarget:self action:@selector(myPosition) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myLodactionButton;
}

-(UIButton *)hotelLocationButton{
    if (!_hotelLocationButton) {
        _hotelLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hotelLocationButton.frame = CGRectMake(BoundWidth-120, BoundHeight-64-60, 100, 30);
        [_hotelLocationButton setTitle:@"酒店位置" forState:UIControlStateNormal];
        _hotelLocationButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_hotelLocationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _hotelLocationButton.backgroundColor = [UIColor whiteColor];
        _hotelLocationButton.layer.cornerRadius = 5;
        [_hotelLocationButton clipsToBounds];
        [_hotelLocationButton addTarget:self action:@selector(hotelPosition) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotelLocationButton;
}

-(UIAlertController *)alertController{
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet ];
        UIAlertAction *appleAction = [UIAlertAction actionWithTitle:@"苹果自带地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
            toLocation.name = self.destination;
            [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                       MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
            
            
        }];
        UIAlertAction *tecentAction = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=0&style=2",@"住哪儿",@"YGche",self.destination,self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else{
                [SVProgressHUD showInfoWithStatus:@"您的手机未安装高德地图"];
            }
           
        }];
        UIAlertAction *baiduAction = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name:%@&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude,self.destination] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]]) {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }else{
                 [SVProgressHUD showInfoWithStatus:@"您的手机未安装百度地图"];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:nil];
        [_alertController addAction:appleAction];
        [_alertController addAction:tecentAction];
        [_alertController  addAction:baiduAction];
        [_alertController addAction:cancelAction];
    }
    return _alertController;
}

@end
