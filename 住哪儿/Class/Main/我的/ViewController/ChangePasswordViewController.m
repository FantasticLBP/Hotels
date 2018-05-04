
//
//  ChangePasswordViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/20.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UserInfo.h"

@interface ChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) NSString *password;
@end

@implementation ChangePasswordViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userInfo = [UserManager getUserObject];
}

#pragma mark - private method
- (void)setupUI{
    self.view.backgroundColor = TableViewBackgroundColor;
    self.title = @"设置密码";
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    [self.view addSubview:self.headerLabel];
    [self.view addSubview:self.tableView];
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.headerLabel.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

-(void)passwordChanged{
    NSString *url = [NSString stringWithFormat:@"%@/controller/api/updateUser.php",Base_Url];
    UserInfo *buddy = [UserManager getUserObject];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"telephone"] = buddy.telephone;
    para[@"password"] = self.password;
    para[@"type"] = UpdaterUser_Password;
    
    [SVProgressHUD showWithStatus:@"正在更改密码"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([dict[@"code"] integerValue]==200){
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [UserManager saveUserObject:self.userInfo];
            [self.navigationController popViewControllerAnimated:YES];
        } else{
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    } fail:^{
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

#pragma mark - UITextfieldDelegat

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 10001) {
        self.password = textField.text;
    }
    if (textField.tag == 10002) {
        if (self.password != textField.text) {
            [SVProgressHUD showInfoWithStatus:@"2次密码不一致"];
        }else{
            self.userInfo.password = textField.text;
        }
    }
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *passwordCellID = @"passwordCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:passwordCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:passwordCellID];
    }
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
        cell.textLabel.text = @"";
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"手机号";
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(BoundWidth-260, 0, 100, 60)];
        field.tag = 1002;
        field.delegate = self;
        field.textAlignment = NSTextAlignmentLeft;
        field.font = [UIFont systemFontOfSize:15];
        field.textColor = [UIColor blackColor];
        field.borderStyle = UITextBorderStyleNone;
        field.text = self.userInfo.telephone;
        [cell.contentView addSubview:field];
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"密码";
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(BoundWidth - 260, 0, 100, 76)];
        field.delegate = self;
        field.tag = 10001;
        field.textAlignment = NSTextAlignmentLeft;
        field.font = [UIFont systemFontOfSize:15];
        field.textColor = [UIColor blackColor];
        field.borderStyle = UITextBorderStyleNone;
        field.secureTextEntry = YES;
        field.placeholder = @"请设置密码";
        [cell.contentView addSubview:field];
    }else{
        cell.textLabel.text = @"重复密码";
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(BoundWidth - 260, 0, 100, 76)];
        field.tag = 10002;
        field.delegate = self;
        field.textAlignment = NSTextAlignmentLeft;
        field.font = [UIFont systemFontOfSize:15];
        field.textColor = [UIColor blackColor];
        field.borderStyle = UITextBorderStyleNone;
        field.secureTextEntry = YES;
        field.placeholder = @"请再次输入";
        [cell.contentView addSubview:field];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -- lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tb.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        tb.tableFooterView = [UIView new];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        _tableView = tb;
    }
    return _tableView;
}

-(UILabel *)headerLabel{
    if (!_headerLabel) {
        _headerLabel = [UILabel new];
        _headerLabel.font = [UIFont systemFontOfSize:14];
        _headerLabel.textColor = [UIColor grayColor];
        _headerLabel.numberOfLines = 0 ;
        _headerLabel.text = @"设置去哪儿密码可以用账号加密码登录。";
    }
    return _headerLabel;
}

-(UIBarButtonItem *)rightBarButtonItem{
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(passwordChanged)];
    }
    return _rightBarButtonItem;
}
@end
