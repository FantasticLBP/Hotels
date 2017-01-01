
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

static NSString *RoomItemCellID = @"RoomItemCell";
#define HeaderInitHeight 70
#define HeaderShowHeight 198

@interface HotelRoomPriceVC ()<RoomInfoHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RoomInfoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isShow;
@end

@implementation HotelRoomPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
            NSLog(@"查看更多图片");
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}


#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"酒店房型报价";
    self.headerView.roomName = @"豪华大床房B";
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

@end
