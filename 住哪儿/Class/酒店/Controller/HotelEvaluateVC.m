
//
//  HotelEvaluateVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelEvaluateVC.h"
#import "HotelEvaluateCell.h"

static NSString *HotelEvaluateCellID = @"HotelEvaluateCell";

@interface HotelEvaluateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *evaluations;

@end

@implementation HotelEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


#pragma mark - private method
-(void)setupUI{
    self.title = @"全部评价";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.evaluations.count + 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:HotelEvaluateCellID forIndexPath:indexPath];
    cell.hidden = YES;
    return cell;
}

#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HotelEvaluateCell" bundle:nil] forCellReuseIdentifier:HotelEvaluateCellID];
        _tableView.backgroundColor = CollectionViewBackgroundColor;
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)evaluations{
    if (!_evaluations) {
        _evaluations = [NSMutableArray array];
    }
    return _evaluations;
}

@end
