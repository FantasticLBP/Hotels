

//
//  FilterHotelVC.m
//  住哪儿
//
//  Created by geek on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "FilterHotelVC.h"
static NSString *TopicConditionCellID = @"TopicConditionCell";

@interface FilterHotelVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation FilterHotelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicConditionCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicConditionCellID];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"jpg-11"];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"玩乐西溪";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = @"曲水环绕，群山四绕";
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
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.topic) {
            self.topic(@"休闲");
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
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
