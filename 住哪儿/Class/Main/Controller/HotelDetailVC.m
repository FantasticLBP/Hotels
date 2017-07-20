
//  HotelDetailVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelDetailVC.h"
#import "HotelImageCell.h"
#import "CheaperHotelCell.h"
#import "HotelTimeCell.h"
#import "HotelKindCell.h"
#import "HotelNoticeCell.h"
#import "HotelBaseConditionCell.h"
#import "HotelEvaluateCell.h"
#import "ShareView.h"
#import <MessageUI/MessageUI.h>

#import "HotelLocationMapVC.h"
#import "HotelAlbumsVC.h"
#import "HotelEvaluateVC.h"
#import "HotelRoomPriceVC.h"
#import "RoomModel.h"

#define ShareViewHeight BoundWidth/2+51
#define ShowShareViewDuration 5.0
static NSString *HotelImageCellID = @"HotelImageCell";
static NSString *HotelTimeCellID = @"HotelTimeCell";
static NSString *HotelKindCellID = @"HotelKindCell";
static NSString *HotelNoticeCellID = @"HotelNoticeCell";
static NSString *HotelBaseConditionCellID = @"HotelBaseConditionCell";
static NSString *HotelEvaluateCellID = @"HotelEvaluateCell";



@interface HotelDetailVC ()<UITableViewDelegate,UITableViewDataSource,
                            HotelImageCellDelegate,
                            ShareViewDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *rooms;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation HotelDetailVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self preData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [UIView animateWithDuration:0.3 animations:^{
        [self.shareView setFrame:CGRectMake(0, BoundHeight, BoundWidth, ShareViewHeight)];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.image = [UIImage imageNamed:@"Share_icon"];
        right.target = self;
        right.action = @selector(showToShare);
        right;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


-(void)showToShare{
    [self.view addSubview:self.shareView];
    [UIView animateWithDuration:0.3 animations:^{
        [self.shareView setFrame:CGRectMake(0,self.view.frame.size.height - self.view.frame.size.width/2-51, BoundWidth, ShareViewHeight)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)preData{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/Room.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"hotelId"] = self.model.hotelId;
    
    [SVProgressHUD showWithStatus:@"正在获取酒店数据"];
    [AFNetPackage getJSONWithUrl:url parameters:paras success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSMutableArray *datas = dic[@"data"];
            for (NSDictionary *dic in datas) {
                [self.rooms addObject:[RoomModel yy_modelWithJSON:dic]];
            }
            
            if ([ProjectUtil isNotBlank:self.model.image1]) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image1]];
            }
            if ([ProjectUtil isNotBlank:self.model.image2]) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image2]];
            }
            if ([ProjectUtil isNotBlank:self.model.image3]) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image3]];
            }
            if ([ProjectUtil isNotBlank:self.model.image4]) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image4]];
            }
            if ([ProjectUtil isNotBlank:self.model.image5]) {
                [self.images addObject:[NSString stringWithFormat:@"%@%@%@",Base_Url,@"/",self.model.image5]];
            }
            
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - ShareViewDelegate
-(void)shareView:(ShareView *)shareView didSelectItemAtIndexPath:(NSInteger)indexPath{
    switch (indexPath) {
        case 0:
            [SVProgressHUD showInfoWithStatus:@"微信好友分享"];
            break;
        case 1:
            [SVProgressHUD showInfoWithStatus:@"微信朋友圈分享"];
            break;
        case 2:
            [SVProgressHUD showInfoWithStatus:@"新浪微博分享"];
            break;
        case 3:
            [SVProgressHUD showInfoWithStatus:@"QQ分享"];
            break;
        case 4:
            [SVProgressHUD showInfoWithStatus:@"QQ空间分享"];
            break;
        case 5:
            if (![MFMessageComposeViewController canSendText]) {    /**<判断能不能发送短信*/
                return ;
            }
            MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
            messageVC.body = @"跟你分享一下这些酒店，真的很赞哦";
            //            messageVC.recipients = @[@"10086"];
            messageVC.messageComposeDelegate = self;
            [self presentViewController:messageVC animated:YES completion:^{
                [self.shareView removeFromSuperview];
            }];
            break;
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rooms.count + 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 311;
    }else if(indexPath.row == 1){
        return 73;
    }else if (indexPath.row == 2){
        return 140;
    }else if (indexPath.row == 7){
        return 62;
    }else if (indexPath.row == 8){
        return 73;
    }else{
        return 90;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HotelImageCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelImageCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.images = self.images;
        cell.hotelModel = self.model;
        return cell;
    }else if(indexPath.row == 1){
        HotelTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelTimeCellID forIndexPath:indexPath];
        cell.startPeriod = self.startPeriod;
        cell.leavePerios = self.leavePerios;
        return  cell;
    }else if (indexPath.row == 2){
        HotelBaseConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelBaseConditionCellID forIndexPath:indexPath];
        cell.model = self.model;
        return  cell;
    }else if (indexPath.row>=3 && indexPath.row < self.rooms.count +3){
        HotelKindCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelKindCellID forIndexPath:indexPath];
        cell.roomModel = self.rooms[indexPath.row - 3];
        return cell;
    }else if (indexPath.row == self.rooms.count +3){
        HotelEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelEvaluateCellID forIndexPath:indexPath];
        return cell;
    }else{
        HotelNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelNoticeCellID forIndexPath:indexPath];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>2 && indexPath.row < self.rooms.count +3) {
        HotelRoomPriceVC *vc = [[HotelRoomPriceVC alloc] init];
        vc.startPeriod = self.startPeriod;
        vc.leavePerios = self.leavePerios;
        vc.model = self.rooms[indexPath.row - 3];
        vc.hotelModel = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == self.rooms.count + 3){
        HotelEvaluateVC *vc = [[HotelEvaluateVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - HotelImageCellDelegate
-(void)hotelImageCell:(HotelImageCell *)hotelImageCell didOperateHotelWithType:(Hotel_Action_Type)type{
    switch (type) {
        case Watch_Hotel_DetailImage:{
            HotelAlbumsVC *vc = [[HotelAlbumsVC alloc] init];
            vc.imageDatas = self.images;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case Watch_Hotel_Map:{
            HotelLocationMapVC *vc = [[HotelLocationMapVC alloc] init];
            vc.destination  = self.model.hotelName;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - lazy load
-(ShareView *)shareView{
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0,BoundHeight, BoundWidth, ShareViewHeight)];
        _shareView.delegate = self;
    }
    return _shareView;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HotelImageCell class] forCellReuseIdentifier:HotelImageCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"HotelTimeCell" bundle:nil] forCellReuseIdentifier:HotelTimeCellID];
        [_tableView registerClass:[HotelKindCell class] forCellReuseIdentifier:HotelKindCellID];
        [_tableView registerClass:[HotelNoticeCell class] forCellReuseIdentifier:HotelNoticeCellID];
        [_tableView registerClass:[HotelBaseConditionCell class] forCellReuseIdentifier:HotelBaseConditionCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"HotelEvaluateCell" bundle:nil] forCellReuseIdentifier:HotelEvaluateCellID];
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)rooms{
    if (!_rooms) {
        _rooms = [NSMutableArray array];
    }
    return _rooms;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
