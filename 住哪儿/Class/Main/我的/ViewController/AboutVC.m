//
//  AboutVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/11/21.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "AboutVC.h"

static NSString *AboutCellID = @"about";


@interface AboutVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于住哪儿";
    self.view.backgroundColor = TableViewBackgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.label];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 42;
    }else{
        return 42;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AboutCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AboutCellID];
    }
    
    if (indexPath.row == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BoundWidth-30, 42)];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"住哪儿是国内领先的酒店在线预订平台";
        [cell.contentView addSubview:label];
    }
    
    if (indexPath.row == 1) {
        UILabel *versionLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 0, BoundWidth-30, 42)];
        versionLabel.font = [UIFont systemFontOfSize:14];

        versionLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        versionLabel.textAlignment = NSTextAlignmentLeft;
        versionLabel.text = @"版本信息:V1.0.0";
        [cell.contentView addSubview:versionLabel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 200)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(BoundWidth/2-70/2, 50, 70, 70)];
    imageView.image = [UIImage imageNamed:@"My_about"];
    
    UILabel *about = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, BoundWidth, 21)];
    about.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    about.textAlignment = NSTextAlignmentCenter;
    about.font = [UIFont systemFontOfSize:14];
    about.text = @"家庭出游新选择";
    
    [header addSubview:imageView];
    [header addSubview:about];
    return header;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.backgroundColor = TableViewBackgroundColor;
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = [[UIView alloc] init];
        _tableView = table;
    }
    return _tableView;
}

-(UILabel *)label{
    if (!_label) {
        UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, BoundHeight-64-50, BoundWidth, 20)];
        version.font = [UIFont systemFontOfSize:12];
        version.textColor = TintTextColor;
        version.textAlignment = NSTextAlignmentCenter;
        version.text = @"Copyright@2016-2017 胡德全 All Rights Reserved";
        _label = version;
    }
    return _label;
}
@end
