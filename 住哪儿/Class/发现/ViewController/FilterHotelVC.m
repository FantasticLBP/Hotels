

//
//  FilterHotelVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "FilterHotelVC.h"
#import "UserManager.h"

static NSString *TopicConditionCellID = @"TopicConditionCell";

@interface FilterHotelVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *subjects;                     /**<主题列表*/

@end

@implementation FilterHotelVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getSubjects];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)getSubjects{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/subject.php"];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"key"] = AppKey;
    [SVProgressHUD showWithStatus:@"正在获取主题列表"];
    [AFNetPackage getJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.subjects = dic[@"data"];
            [self.tableView reloadData];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.subjects[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicConditionCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicConditionCellID];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",Base_Url,dic[@"image"]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Hotel_placeholder"]];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = dic[@"subject"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = dic[@"description"];
    subTitleLabel.textColor = [UIColor colorFromHexCode:@"9c9c9c"];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:subTitleLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell).with.offset(10);
        make.size.mas_offset(CGSizeMake(70, 70));
        make.centerY.equalTo(cell);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).with.offset(5);
        make.top.equalTo(cell).with.offset(20);
        make.height.mas_equalTo(20);
        make.right.equalTo(cell);
    }];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.right.equalTo(titleLabel);
        make.height.mas_equalTo(20);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(5);
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.subjects[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.topic) {
            self.topic(dic[@"id"],dic[@"subject"]);
        }
    }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins=NO;
    
    
}

#pragma mark - private method
-(void)setupUI{
    self.title = [NSString stringWithFormat:@"%@%@",self.cityName,@"主题酒店"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *right = [[UIBarButtonItem alloc] init];
        right.image = [UIImage imageNamed:@"Find_close"];
        right.target = self;
        right.action = @selector(closeThisPage);
        right;
    });
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(void)closeThisPage{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TopicConditionCellID];
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(NSMutableArray *)subjects{
    if (!_subjects) {
        _subjects = [NSMutableArray array];
    }
    return _subjects;
}
@end
