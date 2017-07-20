
//
//  PrivilegeHotelVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "PrivilegeHotelVC.h"
#import "SpecialHotelConditionPickCell.h"
#import "CheaperHotelCell.h"
#import "HotelDetailVC.h"
#import "TimerPickerVC.h"
#import "LBPNavigationController.h"
#import "JFCityViewController.h"

static NSString *SpecialHotelConditionPickCellID = @"SpecialHotelConditionPickCell";
static NSString *CheaperHotelCellID = @"CheaperHotelCell";

@interface PrivilegeHotelVC ()<UITableViewDelegate,UITableViewDataSource,
                                SpecialHotelConditionPickCellDelegate,
                                TimerPickerVCDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *specialHotels;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) SpecialHotelConditionPickCell *conditionView;
@end

@implementation PrivilegeHotelVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    for (int i = 1; i <= 8; i++){
        [self.images addObject:[NSString stringWithFormat:@"jpg-%d",i]];
    }
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"特惠酒店";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(void)loadSpecialHotel{
    
}

#pragma mark - TimerPickerVCDelegate
-(void)timerPickerVC:(TimerPickerVC *)vc didPickedTime:(NSDate *)period{
    LBPLog(@"选择日期:%@",period);
}


#pragma mark - SpecialHotelConditionPickCellDelegate
-(void)specialHotelConditionPickCell:(SpecialHotelConditionPickCell *)cell didClickWithAxctionType:(Operation_Type)type{
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
                LBPLog(@"选择城市%@",cityName);
            }];
            LBPNavigationController *navigationController = [[LBPNavigationController alloc] initWithRootViewController:cityViewController];
            [self presentViewController:navigationController animated:YES completion:nil];
            break;
        }
        case Operation_Type_AutoLocate:{
            LBPLog(@"自动定位");
            break;
        }
        case Operation_Type_SearchHotel:{
            LBPLog(@"查找酒店");
            break;
        }
        case Operation_Type_StarFilter:{
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1 + self.specialHotels.count;
    return  5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 232;
    }else{
        return 120;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SpecialHotelConditionPickCell *cell = [tableView dequeueReusableCellWithIdentifier:SpecialHotelConditionPickCellID];
        cell.delegate = self;
        return cell;
    }else{
        CheaperHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:CheaperHotelCellID forIndexPath:indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotelDetailVC *vc = [[HotelDetailVC alloc] init];
    vc.startPeriod = [[NSDate date] todayString];
    vc.leavePerios = [[NSDate date] GetTomorrowDayString];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsMake(cell.frame.size.height-1, 12, 0, 12);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = TableViewBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //[_tableView registerClass:[SelectConditionCell class] forCellReuseIdentifier:SelectConditionCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SpecialHotelConditionPickCell" bundle:nil] forCellReuseIdentifier:SpecialHotelConditionPickCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CheaperHotelCell" bundle:nil] forCellReuseIdentifier:CheaperHotelCellID];
        __weak typeof(self) WeakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [WeakSelf loadSpecialHotel];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [WeakSelf loadSpecialHotel];
        }];
        _tableView.mj_header.automaticallyChangeAlpha = YES;       // 设置自动切换透明度(在导航栏下面自动隐藏)
    }
    return _tableView;
}

-(NSMutableArray *)specialHotels{
    if (!_specialHotels) {
        _specialHotels = [NSMutableArray array];
    }
    return _specialHotels;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

-(SpecialHotelConditionPickCell *)conditionView{
    if (!_conditionView) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        _conditionView = [_tableView cellForRowAtIndexPath:indexpath];
    }
    return _conditionView;
}
@end
