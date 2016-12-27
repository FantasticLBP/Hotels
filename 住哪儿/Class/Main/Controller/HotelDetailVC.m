
//  HotelDetailVC.m
//  住哪儿
//
//  Created by geek on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelDetailVC.h"
#import "HotelImageCell.h"
#import "CheaperHotelCell.h"
#import "HotelTimeCell.h"
#import "HotelKindCell.h"
#import "HotelNoticeCell.h"

#import "ShareView.h"
#import <MessageUI/MessageUI.h>

#import "HotelLocationMapVC.h"
#import "HotelAlbumsVC.h"

#define ShareViewHeight BoundWidth/2+51
#define ShowShareViewDuration 5.0
static NSString *HotelImageCellID = @"HotelImageCell";
static NSString *HotelTimeCellID = @"HotelTimeCell";
static NSString *HotelKindCellID = @"HotelKindCell";
static NSString *HotelNoticeCellID = @"HotelNoticeCell";


@interface HotelDetailVC ()<UITableViewDelegate,UITableViewDataSource,
                            HotelImageCellDelegate,
                            ShareViewDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotelTypes;
@end

@implementation HotelDetailVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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

#pragma mark - MEss
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotelTypes.count + 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 311;
    }else if(indexPath.row == 1){
        return 73;
    }else if (indexPath.row == 6){
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
        return cell;
    }else if(indexPath.row == 1){
        HotelTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelTimeCellID forIndexPath:indexPath];
        return  cell;
    }else if(indexPath.row == 6){
        HotelNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelNoticeCellID forIndexPath:indexPath];
        return cell;
    }else{
        HotelKindCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelKindCellID forIndexPath:indexPath];
        cell.imageName = @"jpg-9";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 1; i <= 8; i++){
            [_images addObject:[NSString stringWithFormat:@"jpg-%d",i]];
        }
    }
    return _images;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HotelImageCell class] forCellReuseIdentifier:HotelImageCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"HotelTimeCell" bundle:nil] forCellReuseIdentifier:HotelTimeCellID];
        [_tableView registerClass:[HotelKindCell class] forCellReuseIdentifier:HotelKindCellID];
        [_tableView registerClass:[HotelNoticeCell class] forCellReuseIdentifier:HotelNoticeCellID];
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)hotelTypes{
    if (!_hotelTypes) {
        _hotelTypes = [NSMutableArray array];
    }
    return _hotelTypes;
}

@end
