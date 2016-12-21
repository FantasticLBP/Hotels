
//
//  PrivilegeHotelVC.m
//  住哪儿
//
//  Created by geek on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "PrivilegeHotelVC.h"
#import "ShareView.h"
#import <MessageUI/MessageUI.h>

#define ShareViewHeight BoundWidth/2+51
#define ShowShareViewDuration 5.0

@interface PrivilegeHotelVC ()<ShareViewDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) ShareView *shareView;
@end

@implementation PrivilegeHotelVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.view.backgroundColor = CollectionViewBackgroundColor;
    self.title = @"特惠酒店";
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.image = [UIImage imageNamed:@"Share_icon"];
        right.target = self;
        right.action = @selector(showToShare);
        right;
    });
    [self.view addSubview:self.shareView];
}

-(void)showToShare{
    [UIView animateWithDuration:ShowShareViewDuration animations:^{
        
    } completion:^(BOOL finished) {
        self.shareView.center = CGPointMake(self.view.center.x, BoundHeight-ShareViewHeight/2);
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
            messageVC.body = @"跟你分享一下这个酒店，真的很赞哦";
            messageVC.recipients = @[@"10086"];
            messageVC.messageComposeDelegate = self;
            [self presentViewController:messageVC animated:YES completion:^{
                
            }];
            break;
    }
}

#pragma mark - MEss
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy load
-(ShareView *)shareView{
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, BoundHeight, BoundWidth, ShareViewHeight)];
        _shareView.delegate = self;
    }
    return _shareView;
}

@end
