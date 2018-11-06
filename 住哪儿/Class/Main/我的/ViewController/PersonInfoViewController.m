
//
//  PersonInfoViewController.m
//  住哪儿
//
//  Created by 杭城小刘 on 2017/1/19.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "ChangeUserNameVC.h"
#import "HcdDateTimePickerView.h"
#import "ChangePasswordViewController.h"


@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,
                                        UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) HcdDateTimePickerView * dateTimePickerView;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userInfo = [UserManager getUserObject];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 76;
    }else{
        return 48;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *personCellID = @"personalCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:personCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:personCellID];
    }
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
        cell.textLabel.text = @"";
    }
    
    if (indexPath.row == 0 ) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(BoundWidth-100, 10 , 56, 56)];
        imageView.layer.cornerRadius = 28;
        imageView.layer.masksToBounds = YES;
        
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 160, 76)];
        usernameLabel.textAlignment = NSTextAlignmentLeft;
        usernameLabel.font = [UIFont systemFontOfSize:15];
        usernameLabel.textColor = [UIColor blackColor];
        usernameLabel.text = @"用户头像";
        
        UserInfo *userInfo = [UserManager getUserObject];
        NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,userInfo.avator]; 
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"profile"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:usernameLabel];
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"姓名";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 120, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.nickname;
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"性别";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 120, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.gender;
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"生日";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 120, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.birthday;
        [cell.contentView addSubview:label];
    }else {
        cell.textLabel.text = @"修改密码";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imagePicker.delegate = self;
                    imagePicker.allowsEditing = YES;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"您的设备不支持拍照！"];
                }
            }];
            UIAlertAction *library = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;     //选择类型，表示从相册中选取照片
                imagePicker.delegate = self;        //指定代理，实现UIImagePickerControllerDelegate，UINavigationControllerDelegate
                imagePicker.allowsEditing = YES;           //设置在相册中选取照片后，是否跳到编辑模式进行图片剪裁
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:photo];
            [alert addAction:library];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 1:{
            ChangeUserNameVC *vc = [[ChangeUserNameVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *url = [NSString stringWithFormat:@"%@/controller/api/updateUser.php",Base_Url];
                UserInfo *buddy = [UserManager getUserObject];
                
                NSMutableDictionary *para = [NSMutableDictionary dictionary];
                para[@"telephone"] = buddy.telephone;
                para[@"gender"] = @"男";
                para[@"type"] = UpdaterUser_Gender;
                
                [SVProgressHUD show];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
                    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    
                    if ([dict[@"code"] integerValue]==200){
                        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                        buddy.gender = @"男";
                        [UserManager saveUserObject:buddy];
                        self.userInfo = [UserManager getUserObject];
                        [self.tableView reloadData];

                    } else{
                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    }
                } fail:^{
                    [SVProgressHUD showErrorWithStatus:@"网络错误"];
                }];
            }];
            UIAlertAction *women = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *url = [NSString stringWithFormat:@"%@/controller/api/updateUser.php",Base_Url];
                UserInfo *buddy = [UserManager getUserObject];
                
                NSMutableDictionary *para = [NSMutableDictionary dictionary];
                para[@"telephone"] = buddy.telephone;
                para[@"gender"] = @"女";
                para[@"type"] = UpdaterUser_Gender;
                
                [SVProgressHUD show];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
                    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    
                    if ([dict[@"code"] integerValue]==200){
                        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                        buddy.gender = @"女";
                        [UserManager saveUserObject:buddy];
                        self.userInfo = [UserManager getUserObject];
                        [self.tableView reloadData];
                        
                    } else{
                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    }
                } fail:^{
                    [SVProgressHUD showErrorWithStatus:@"网络错误"];
                }];            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:man];
            [alert addAction:women];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 3:{
            __weak typeof(self) WeakSelf = self;
            self.dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
            [self.dateTimePickerView setMinYear:1900];
            [self.dateTimePickerView setMaxYear:2016];
            self.dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
                NSString *url = [NSString stringWithFormat:@"%@/controller/api/updateUser.php",Base_Url];
                UserInfo *buddy = [UserManager getUserObject];
                
                NSMutableDictionary *para = [NSMutableDictionary dictionary];
                para[@"telephone"] = buddy.telephone;
                para[@"birthday"] = datetimeStr;
                para[@"type"] = UpdaterUser_Birthday;

                [SVProgressHUD show];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
                    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    
                    if ([dict[@"code"] integerValue]==200){
                        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                        buddy.birthday = datetimeStr;
                        [UserManager saveUserObject:buddy];
                        [UserManager saveUserObject:buddy];
                        WeakSelf.userInfo = [UserManager getUserObject];
                        [WeakSelf.tableView reloadData];
                        
                    } else{
                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    }
                } fail:^{
                    [SVProgressHUD showErrorWithStatus:@"网络错误"];
                }];
            };

            if (self.dateTimePickerView) {
                [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateTimePickerView];
                [self.dateTimePickerView showHcdDateTimePicker];
            }
            break;
        }
        case 4:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证原密码" message:@"为保障您的数据安全，修改密码前请填写原密码" preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.secureTextEntry = YES;
                
            }];

            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UserInfo *userInfo = [UserManager getUserObject];
               UITextField *passwordTextField = alert.textFields.firstObject;
                if (![passwordTextField.text isEqualToString:userInfo.password]) {
                    [SVProgressHUD showErrorWithStatus:@"密码错误，请重新输入。"];
                }else{
                    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
            }];
            [alert addAction:cancel];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    NSString *url = [NSString stringWithFormat:@"%@/controller/api/upload.php",Base_Url];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserManager getUserObject];
    para[@"telephone"] = userInfo.telephone;
    [SVProgressHUD showWithStatus:@"正在上传"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [AFNetPackage postUploadWithUrl:url para:para name:@"myAvator" fileData:imageData fileName:@"1.jpg" fileType:@"image/jpeg" success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"头像上传成功"];
            userInfo.avator = responseObject[@"data"][@"avator"];
            [UserManager saveUserObject:userInfo];
        }
        [self.tableView reloadData];
    } fail:^{
        [SVProgressHUD showErrorWithStatus:@"网络状况不佳，请稍后尝试。"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tb.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        tb.tableFooterView = [UIView new];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = TableViewBackgroundColor;
        _tableView = tb;
    }
    return _tableView;
}

@end
