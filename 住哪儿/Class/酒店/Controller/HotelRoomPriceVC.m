
//
//  HotelRoomPriceVC.m
//  住哪儿
//
//  Created by geek on 2016/12/28.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelRoomPriceVC.h"
#import "RoomInfoHeaderView.h"

@interface HotelRoomPriceVC ()<RoomInfoHeaderViewDelegate>
@property (nonatomic, strong) RoomInfoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

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
            NSLog(@"查看更多信息");
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

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"酒店房型报价";
    self.headerView.roomName = @"豪华大床房B";
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
}

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
//        _tableView.dataSource=self;
//        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
