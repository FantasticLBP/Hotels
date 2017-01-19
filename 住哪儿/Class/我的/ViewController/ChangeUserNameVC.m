//
//  ChangeUserNameVC.m
//  heletalk-patient
//
//  Created by fpp on 15/9/21.
//  Copyright (c) 2015年 heletech. All rights reserved.
//

#import "ChangeUserNameVC.h"
#import "AFNetPackage.h"
#import "UserManager.h"

@interface ChangeUserNameVC ()
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ChangeUserNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
    [self.view setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)]];
    UserInfo *buddy = [UserManager getUserObject];
    self.textField.text = buddy.userName;
    [self.view addSubview:self.textField];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

-(void)clickRightButton{
    UserInfo *buddy = [UserManager getUserObject];
    if ([buddy.userName isEqualToString:self.textField.text]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
        [self updateUser];
    
}

-(void)updateUser{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    UserInfo *userInfo = [UserManager getUserObject];
    userInfo.userName = self.textField.text;
    [UserManager saveUserObject:userInfo];
    
    /*
    NSString *urlString=[NSString stringWithFormat:@"UpdatePersonalInfoUrl",@"LoginHuanxinId"];
    NSDictionary *para=@{@"name":self.textField.text};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [AFNetPackage postJSONWithUrl:urlString parameters:para success:^(id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([dict[@"status"] integerValue]==200){
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            UserInfo *buddy = [UserManager getUserObject];
            buddy.userName = self.textField.text;
            [UserManager saveUserObject:buddy];
            [self.navigationController popViewControllerAnimated:YES];
        } else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    } fail:^{
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
     */
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 20, BoundWidth-16, 40)];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

@end
