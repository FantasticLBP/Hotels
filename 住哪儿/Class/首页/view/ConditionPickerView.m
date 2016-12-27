//
//  ConditionPickerView.m
//  住哪儿
//
//  Created by geek on 2016/12/8.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ConditionPickerView.h"

#define CellHeight 46
#define LocateButtonMarginLeft 310
#define LocateButtonOriginY 80
#define InLabelHeight 21


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
    return CellHeight;
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
        UILabel *localtionabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CellHeight)];
        localtionabel.text = @"北京";
        localtionabel.textColor = [UIColor blackColor];
        localtionabel.font = [UIFont systemFontOfSize:15];
        localtionabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        locateBtn.frame = CGRectMake(LocateButtonMarginLeft, 0, LocateButtonOriginY, CellHeight);
        [locateBtn setImage:[UIImage imageNamed:@"locate"] forState:UIControlStateNormal];
        [locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
        [locateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        locateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 23, 0);
//        locateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        locateBtn.titleLabel.center = CGPointMake(40, 10);
//        locateBtn.imageView.center = CGPointMake(40,  30);
//        [locateBtn setNeedsLayout];
        locateBtn.backgroundColor = [UIColor whiteColor];
        locateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [locateBtn addTarget:self action:@selector(locate) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:localtionabel];
        [cell.contentView addSubview:locateBtn];
    }else if (indexPath.row == 1){
        UILabel *inLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (BoundWidth-20)/2-19, InLabelHeight)];
        inLabel.textAlignment = NSTextAlignmentCenter;
        inLabel.textColor = PlaceHolderColor;
        inLabel.font = [UIFont systemFontOfSize:12];
        inLabel.text = @"入住";
        
        UILabel *inDatelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, InLabelHeight, (BoundWidth-20)/2-19, 25)];
        inDatelabel.textAlignment = NSTextAlignmentCenter;
        inDatelabel.textColor = [UIColor blackColor];
        inDatelabel.font = [UIFont systemFontOfSize:18];
        inDatelabel.text = [[NSDate sharedInstance] today];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19, 23-7, 38, 14)];
        totalLabel.textColor = [UIColor blackColor];
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = [UIFont systemFontOfSize:10];
        totalLabel.layer.borderColor = PlaceHolderColor.CGColor;
        totalLabel.layer.borderWidth = 1;
        totalLabel.layer.cornerRadius = 7;
        totalLabel.layer.masksToBounds = YES;
        totalLabel.text = @"共一晚";
        
        UILabel *outLabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19+38, 0, (BoundWidth-20)/2-19, InLabelHeight)];
        outLabel.textAlignment = NSTextAlignmentCenter;
        outLabel.textColor = PlaceHolderColor;
        outLabel.font = [UIFont systemFontOfSize:12];
        outLabel.text = @"离店";
        
        UILabel *outDatelabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19+38, 21, (BoundWidth-20)/2-19, 25)];
        outDatelabel.textAlignment = NSTextAlignmentCenter;
        outDatelabel.textColor = [UIColor blackColor];
        outDatelabel.font = [UIFont systemFontOfSize:18];
        outDatelabel.text = [[NSDate date] today];
        
        [cell.contentView addSubview:inLabel];
        [cell.contentView addSubview:inDatelabel];
        [cell.contentView addSubview:totalLabel];
        [cell.contentView addSubview:outLabel];
        [cell.contentView addSubview:outDatelabel];
    }else if (indexPath.row == 2){
        UILabel *destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BoundWidth-20, CellHeight)];
        destinationLabel.textAlignment = NSTextAlignmentCenter;
        destinationLabel.textColor = [UIColor blackColor];
        destinationLabel.font = [UIFont systemFontOfSize:18];
        destinationLabel.text = @"首都机场T1航站楼";
        [cell.contentView addSubview:destinationLabel];
    }else{
        UILabel *starLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BoundWidth-20, CellHeight)];
        starLevelLabel.textAlignment = NSTextAlignmentCenter;
        starLevelLabel.textColor = PlaceHolderColor;
        starLevelLabel.font = [UIFont systemFontOfSize:18];
        starLevelLabel.text = @"星级";
        [cell.contentView addSubview:starLevelLabel];
    }
    
    
    
    
    
    return cell;
}


#pragma mark - button method
-(void)searchHotel{
    
}

-(void)locate{
    
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
