
//
//  HotelRoomPriceVC.m
//  住哪儿
//
//  Created by geek on 2016/12/28.
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
@property (nonatomic, strong) RoomDetailInfoView *detailView;
@property (nonatomic, strong) NSMutableArray *photos;        /**< 图片浏览器展示图片数组*/
@property (nonatomic, strong) NSMutableArray *imageDatas;

@end

@implementation HotelRoomPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageDatas = [NSMutableArray arrayWithArray:@[@"jpg-1",@"jpg-2"]];
    [self setupUI];
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
                UIImage *tempImage = [UIImage imageNamed:imageName];
                [self.photos addObject:[MWPhoto photoWithImage:tempImage]];
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
-(void)roomItemCell:(RoomItemCell *)cell didBookRoom:(BOOL)flag{
    if (flag) {
        HotelOrderFillVC *vc = [[HotelOrderFillVC alloc] init];
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
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsZero];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomItemCell *cell = [tableView dequeueReusableCellWithIdentifier:RoomItemCellID forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.detailView];
}


#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"酒店房型报价";
    self.headerView.roomName = @"豪华大床房B";
    self.headerView.otherInfo = @"双人床1.8米1张；单人床1.2米2张";
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

-(RoomDetailInfoView *)detailView{
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"RoomDetailInfoView" owner:nil options:nil] lastObject];
        _detailView.frame = CGRectMake(0, 0, BoundWidth, BoundHeight);
    }
    return _detailView;
}

-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end
