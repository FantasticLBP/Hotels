

//
//  LoginViewController.m
//  KSGuidViewDemo
//
//  Created by geek on 2016/10/24.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *wechatButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

    
}


#pragma mark - Private method
-(void)setupUI{
    self.title = @"登录";
    self.inputView.layer.cornerRadius = 3.0f;
    
    self.loginButton.layer.cornerRadius = 3.0f;
    
}

- (IBAction)clickLoginButton:(id)sender {
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入账号"];
        return ;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return ;
    }
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"username"] = self.usernameTextField.text;
    par[@"password"] = self.passwordTextField.text;
    
    [SVProgressHUD showWithStatus:@"正在登录..."];
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@""];
    [AFNetPackage postJSONWithUrl:url parameters:par success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([json[@"status"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:json[@"msg"]];
        }
    } fail:^{
         [SVProgressHUD showErrorWithStatus:@"网络状况不佳，请稍后尝试"];
    }];
    
}

- (IBAction)clickWechatButton:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"暂不支持微信登录"];
}



#pragma mark - lazy load

@end
