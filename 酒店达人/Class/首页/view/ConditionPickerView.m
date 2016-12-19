//
//  ConditionPickerView.m
//  酒店达人
//
//  Created by geek on 2016/12/8.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ConditionPickerView.h"

@interface ConditionPickerView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *searchButton;

@end
@implementation ConditionPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


#pragma mark - private method
-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self.topView addSubview:self.hotelLabel];
    [self addSubview:self.tableView];
    self.tableView.tableFooterView = self.searchButton;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [self.hotelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView);
        make.left.mas_equalTo(BoundWidth/2-50);
        make.right.mas_equalTo(-(BoundWidth/2-50));
        make.height.mas_equalTo(40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.mas_equalTo(40);
        make.bottom.equalTo(self);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    
    
}



#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELLID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    if (indexPath.row == 0 ) {
        UILabel *localtionabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
        localtionabel.text = @"北京";
        localtionabel.textColor = [UIColor blackColor];
        localtionabel.font = [UIFont systemFontOfSize:15];
        localtionabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:localtionabel];
    }
    
    
    
    
    
    return cell;
}


#pragma mark - button method
-(void)searchHotel{
    
}

#pragma mark - lazy load
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectZero];
        _topView.backgroundColor = CollectionViewBackgroundColor;
    }
    return _topView;
}

-(UILabel *)hotelLabel{
    if (!_hotelLabel) {
        _hotelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _hotelLabel.backgroundColor = [UIColor clearColor];
        _hotelLabel.textColor = DefaultButtonColor;
        _hotelLabel.textAlignment = NSTextAlignmentCenter;
        _hotelLabel.font = [UIFont systemFontOfSize:18];
        _hotelLabel.text = @"国内酒店";
    }
    return  _hotelLabel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _searchButton.backgroundColor = DefaultButtonColor;
        [_searchButton setTitle:@"查找酒店" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchHotel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
@end
