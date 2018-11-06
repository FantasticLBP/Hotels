
//
//  HotelRoomPriceVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelRoomPriceVC.h"
#import "RoomInfoHeaderView.h"
#import "RoomItemCell.h"
#import "RoomDetailInfoView.h"
#import "HotelOrderFillVC.h"
#import "MWPhotoBrowser.h"


static NSString *RoomItemCellID = @"RoomItemCell";
#define HeaderInitHeight 70
#define HeaderShowHeight 198

@interface HotelRoomPriceVC ()<RoomInfoHeaderViewDelegate,
                            RoomItemCellDelegate,
                            MWPhotoBrowserDelegate,
                            UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RoomInfoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSMutableArray *photos;        /**< 图片浏览器展示图片数组*/
@property (nonatomic, strong) NSMutableArray *imageDatas;
@property (nonatomic, strong) NSMutableArray *prices;
@end

@implementation HotelRoomPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([ProjectUtil isNotBlank:self.model.image1]) {
         [self.imageDatas addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image1]];
    }
    if ([ProjectUtil isNotBlank:self.model.image2]) {
        [self.imageDatas addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image2]];
    }
    if ([ProjectUtil isNotBlank:self.model.image3]) {
        [self.imageDatas addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image3]];
    }
    if ([ProjectUtil isNotBlank:self.model.image4]) {
        [self.imageDatas addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image4]];
    }
    if ([ProjectUtil isNotBlank:self.model.image5]) {
        [self.imageDatas addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image5]];
    }
    [self setupUI];
    
    
    [self.prices  addObject:[NSString stringWithFormat:@"%zd",self.model.znecancelPrice]];
    [self.prices  addObject:[NSString stringWithFormat:@"%zd",self.model.znePrice]];
    [self.prices  addObject:[NSString stringWithFormat:@"%zd",self.model.delegatecancelPrice]];
    [self.prices  addObject:[NSString stringWithFormat:@"%zd",self.model.delegatePrice]];
    
}


#pragma mark - RoomInfoHeaderViewDelegate
-(void)roomInfoHeaderView:(RoomInfoHeaderView *)roomInfoHeaderView didOperateWithTag:(RoomOperationType)type{
    switch (type) {
        case RoomOperationType_MoreInfo:{
            [self updateUI];
            break;
        }
        case RoomOperationType_MorePhoto:{
            self.photos = nil;
            
            for (NSString *imageName in self.imageDatas) {
                if ([ProjectUtil isNotBlank:imageName]) {
                    UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
                    [self.photos addObject:[MWPhoto photoWithImage:tempImage]];
                }
            }
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = YES;
            [browser setCurrentPhotoIndex:0];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:browser];
            [browser.navigationController.navigationBar setTitleTextAttributes:  @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - RoomItemCellDelegate
-(void)roomItemCell:(RoomItemCell *)cell didBookRoom:(BOOL)flag price:(NSString *)price{
    if (flag) {
        HotelOrderFillVC *vc = [[HotelOrderFillVC alloc] init];
        vc.startPeriod = self.startPeriod;
        vc.leavePerios = self.leavePerios;
        vc.model = self.hotelModel;
        vc.price = price;
        vc.roomModel = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsZero];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomItemCell *cell = [tableView dequeueReusableCellWithIdentifier:RoomItemCellID forIndexPath:indexPath];
    if (self.prices.count >0) {
        cell.price = self.prices[indexPath.row];
    }
    switch (indexPath.row) {
        case 0:
            cell.priceType = @"住哪儿可取消价格";
            break;
        case 1:
            cell.priceType = @"住哪儿不可取消价格";
            break;
        case 2:
            cell.priceType = @"代理可取消价格";
            break;
        case 3:
            cell.priceType = @"代理不可取消价格";
            break;
        default:
        break;
    }
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RoomDetailInfoView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"RoomDetailInfoView" owner:nil options:nil] lastObject];
    detailView.frame = CGRectMake(0, 0, BoundWidth, BoundHeight);
    detailView.price = self.prices[indexPath.row];
    [[[UIApplication sharedApplication] keyWindow] addSubview:detailView];
}


#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"酒店房型报价";
    self.headerView.roomModel = self.model;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
}

-(void)updateUI{
    if (self.isShow) {
        self.isShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.headerView.frame = CGRectMake(0, 0, BoundWidth, HeaderInitHeight);
            self.tableView.frame = CGRectMake(0, HeaderInitHeight, BoundWidth, BoundHeight - HeaderInitHeight);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        self.isShow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.headerView.frame = CGRectMake(0, 0, BoundWidth, HeaderShowHeight);
            self.tableView.frame = CGRectMake(0, HeaderShowHeight, BoundWidth, BoundHeight - HeaderShowHeight);
        } completion:^(BOOL finished) {
           
        }];
    }
}

#pragma mark - lazy load
-(RoomInfoHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[RoomInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 70)];
        _headerView.delegate = self;
    }
    return _headerView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 70, BoundWidth, BoundHeight-70) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerNib:[UINib nibWithNibName:@"RoomItemCell" bundle:nil] forCellReuseIdentifier:RoomItemCellID];
    }
    return _tableView;
}

-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

-(NSMutableArray *)prices{
    if (!_prices) {
        _prices = [NSMutableArray array];
    }
    return _prices;
}

-(NSMutableArray *)imageDatas{
    if (!_imageDatas) {
        _imageDatas = [NSMutableArray array];
    }
    return _imageDatas;
}

@end
