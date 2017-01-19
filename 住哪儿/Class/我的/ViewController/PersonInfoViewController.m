
//
//  PersonInfoViewController.m
//  住哪儿
//
//  Created by geek on 2017/1/19.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "ChangeUserNameVC.h"
#import "HcdDateTimePickerView.h"



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
        
        NSString *urlName = [NSString stringWithFormat:@"%@%@%@.jpg",Base_Url,Avator_URL,@""];
        UserInfo *userInfo = [UserManager getUserObject];
        NSData *avatorData = UIImagePNGRepresentation(userInfo.avator);
        if (avatorData.length>0) {
            imageView.image = userInfo.avator;
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlName] placeholderImage:[UIImage imageNamed:@"profile"]];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:usernameLabel];
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"昵称";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 100, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.userName;
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"性别";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 100, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.gender;
        [cell.contentView addSubview:label];
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"生日";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 100, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.birthday;
        [cell.contentView addSubview:label];
    }else {
        cell.textLabel.text = @"修改密码";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth - 100, 0, 100, 76)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.text = self.userInfo.password;
        [cell.contentView addSubview:label];
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *man = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UserInfo *userInfo = [UserManager getUserObject];
                userInfo.gender = @"男";
                [UserManager saveUserObject:userInfo];
                self.userInfo = [UserManager getUserObject];
                [self.tableView reloadData];
            }];
            UIAlertAction *women = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UserInfo *userInfo = [UserManager getUserObject];
                userInfo.gender = @"女";
                [UserManager saveUserObject:userInfo];
                self.userInfo = [UserManager getUserObject];
                [self.tableView reloadData];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
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
                UserInfo *userInfo = [UserManager getUserObject];
                userInfo.birthday = datetimeStr;
                [UserManager saveUserObject:userInfo];
                WeakSelf.userInfo = [UserManager getUserObject];
                [WeakSelf.tableView reloadData];
            };

            if (self.dateTimePickerView) {
                [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateTimePickerView];
                [self.dateTimePickerView showHcdDateTimePicker];
            }
            break;
        }
        case 4:{
            NSLog(@"更换密码");
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    UserInfo *userInfo = [UserManager getUserObject];
    userInfo.avator = image;
    [UserManager saveUserObject:userInfo];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
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
