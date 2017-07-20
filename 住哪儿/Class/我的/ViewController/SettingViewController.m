
//
//  SettingViewController.m
//  KSGuidViewDemo
//
//  Created by 杭城小刘 on 2016/10/14.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "MyCollectionVC.h"
#import "MyScanHistoryListVC.h"
#import "MyNotificationVC.h"
#import "FAQVC.h"
#import "FeedBackVC.h"
#import "AboutVC.h"
#import "ImageVC.h"
#import "PersonInfoViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfo *userInfo;
@end

@implementation SettingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userInfo = [UserManager getUserObject];
    [self.tableView reloadData];
}

#pragma mark -private method
-(void)logoutUser{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:nil];
        [UserManager logoOut];
        self.userInfo = [UserManager getUserObject];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)manifyImage{
    LBPLog(@"更换头像");
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section == 1){
        return 1;
    }
    if(section==2){
        return 6;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 75;
    }else{
        return 48;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==3) {
        if ([UserManager isLogin]) {
            return 100;
        }
        return 0;
    }else{
        return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    if (section==3 && [UserManager isLogin]) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((BoundWidth-280)/2, 20, 280, 42)];
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button setBackgroundColor:GlobalMainColor];
        button.layer.cornerRadius = 5.0f;
        [button addTarget:self action:@selector(logoutUser) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
        cell.textLabel.text = @"";
    }
    
    if (indexPath.section == 0 ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 55, 55)];
        imageView.tag = 105;
        imageView.userInteractionEnabled = YES;
        
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 160, 75)];
        usernameLabel.textAlignment = NSTextAlignmentLeft;
        usernameLabel.font = [UIFont systemFontOfSize:15];
        usernameLabel.textColor = [UIColor blackColor];
        if ([ProjectUtil isNotBlank:self.userInfo.telephone]) {
            if ([ProjectUtil isBlank:self.userInfo.nickname]) {
                usernameLabel.text = @"请修改完善个人信息";
            }else{
                usernameLabel.text = self.userInfo.nickname;
            }
        }
        
        UITapGestureRecognizer *taping = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manifyImage)];
        [imageView addGestureRecognizer:taping];
        imageView.layer.cornerRadius = 27.5;
        imageView.layer.masksToBounds = YES;
        
        UserInfo *userInfo = [UserManager getUserObject];
        NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,userInfo.avator];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"profile"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:usernameLabel];
    }
    
    if (indexPath.section ==1 && indexPath.row == 0) {
        cell.textLabel.text = @"我的优惠券";
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"芝麻信用";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"我的收藏";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"我的浏览记录";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"我的通知";
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"在线咨询与投诉";
        }else{
            cell.textLabel.text = @"拨打客服电话";
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"给个好评行不行";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"常见问题解答";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"推荐住哪儿给朋友";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"意见反馈";
        }else{
            cell.textLabel.text = @"关于住哪儿";
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (![UserManager isLogin]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
            LoginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:loginVC animated:YES];
        }else{
            PersonInfoViewController *vc = [[PersonInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0 ) {
            LBPLog(@"点击了我的优惠券");
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            LBPLog(@"芝麻信用");
            ImageVC *vc = [[ImageVC alloc] init];
            vc.imageName = @"XZQ";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            MyCollectionVC *vc = [[MyCollectionVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            MyScanHistoryListVC *vc = [[MyScanHistoryListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            MyNotificationVC *vc = [[MyNotificationVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            LBPLog(@"在线咨询与投诉");
        }else if (indexPath.row == 5){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打客服电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *tel = [UIAlertAction actionWithTitle:TelePhoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableString * telUrl = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",TelePhoneNumber];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
            }];
            [alert addAction:tel];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            LBPLog(@"1");
        }else if (indexPath.row == 1) {
            FAQVC *vc = [[FAQVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"推荐住哪儿给朋友" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *wechat = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD showInfoWithStatus:@"微信好友"];
            }];
            UIAlertAction *wechatFriendCircle = [UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD showInfoWithStatus:@"微信朋友圈"];
            }];
            UIAlertAction *QQFriend = [UIAlertAction actionWithTitle:@"QQ好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD showInfoWithStatus:@"QQ好友"];
            }];
            UIAlertAction *sinaWeibo = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD showInfoWithStatus:@"新浪微博"];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:wechat];
            [alert addAction:wechatFriendCircle];
            [alert addAction:QQFriend];
            [alert addAction:sinaWeibo];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else if (indexPath.row == 3) {
            FeedBackVC *vc = [[FeedBackVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            AboutVC *vc = [[AboutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark -- lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        tb.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView = tb;
    }
    return _tableView;
}

@end
