
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
    if (section == 0 ){
        return 1;
    }
    if(section == 1){
        return 2;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else{
        return 48;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
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
    if (section == 1 && [UserManager isLogin]) {
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
    
    if (indexPath.section == 1 ) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"拨打客服电话";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"关于幸运计划助手";
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
        if (indexPath.row == 0){
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
        } else {
            AboutVC *vc = [[AboutVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark -- lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight - 64) style:UITableViewStyleGrouped];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        tb.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView = tb;
    }
    return _tableView;
}

@end
