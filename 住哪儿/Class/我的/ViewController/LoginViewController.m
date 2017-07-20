

//
//  LoginViewController.m
//  KSGuidViewDemo
//
//  Created by 杭城小刘 on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *wechatButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - Private method
-(void)setupUI{
    self.title = @"登录";
    self.inputView.layer.cornerRadius = 3.0f;
    self.loginButton.layer.cornerRadius = 5.0f;
    self.registerButton.layer.cornerRadius = 5.0f;
    self.loginButton.backgroundColor = GlobalMainColor;
    self.registerButton.backgroundColor = GlobalMainColor;
}

- (IBAction)clickLoginButton:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@/controller/api/login.php",Base_Url];
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        return ;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return ;
    }
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"telephone"] = self.usernameTextField.text;
    para[@"password"] = self.passwordTextField.text;
    [SVProgressHUD showInfoWithStatus:@"正在登录"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([json[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.id = json[@"data"][@"id"];
            userInfo.telephone = json[@"data"][@"telephone"];
            userInfo.password =  json[@"data"][@"password"];
            userInfo.avator =  json[@"data"][@"avator"];
            userInfo.birthday =  json[@"data"][@"birthday"];
            userInfo.gender =  json[@"data"][@"gender"];
            userInfo.account =  json[@"data"][@"account"];
            userInfo.nickname =  json[@"data"][@"nickname"];
            [UserManager saveUserObject:userInfo];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)clickRegisterButton:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@/controller/api/register.php",Base_Url];
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        return ;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return ;
    }
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"telephone"] = self.usernameTextField.text;
    para[@"password"] = self.passwordTextField.text;
    [SVProgressHUD showInfoWithStatus:@"正在注册"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([json[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            UserInfo *userInfo = [[UserInfo alloc] init];
            userInfo.telephone = self.usernameTextField.text;
            userInfo.password = self.passwordTextField.text;
            [UserManager saveUserObject:userInfo];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)clickWechatButton:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"暂不支持微信登录"];
}



#pragma mark - lazy load

@end
