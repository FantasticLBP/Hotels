//
//  ConditionPickerView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/8.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ConditionPickerView.h"
#import "PriceAndStarLevelPickerView.h"

#define CellHeight 46
#define LocateButtonMarginLeft 310
#define LocateButtonOriginY 80
#define InLabelHeight 21


@interface ConditionPickerView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NSMutableString *selectedResult;             /**<条件选择结果*/
@property (nonatomic, strong) NSString *selectedEnddate;                    /**<选择的离店时间格式化字符串*/
@property (nonatomic, assign) NSInteger totalDay;                          /**<住宿几天*/
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSMutableDictionary *pickedData;
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

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 10000) {
        self.hotelName = textField.text;
        [self.pickedData setObject:self.hotelName forKey:@"pickedHotelName"];
    }
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
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (indexPath.row == 0 ) {
        UILabel *localtionabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CellHeight)];
        localtionabel.text = [ProjectUtil isBlank:[ProjectUtil getFirstCityName]] ?@"北京" :[ProjectUtil getFirstCityName];
        localtionabel.textColor = [UIColor blackColor];
        localtionabel.font = [UIFont systemFontOfSize:15];
        localtionabel.textAlignment = NSTextAlignmentCenter;
        
        UITapGestureRecognizer *locater = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locate)];
        locater.cancelsTouchesInView = YES;
        localtionabel.userInteractionEnabled = YES;
        [localtionabel addGestureRecognizer:locater];

        
        
        
        UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        locateBtn.frame = CGRectMake(LocateButtonMarginLeft, 0, LocateButtonOriginY, CellHeight);
        [locateBtn setImage:[UIImage imageNamed:@"locate"] forState:UIControlStateNormal];
        [locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
        [locateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        locateBtn.backgroundColor = [UIColor whiteColor];
        locateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [locateBtn addTarget:self action:@selector(autoLocate) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        UITapGestureRecognizer *pickInTimer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickInTime)];
        pickInTimer.cancelsTouchesInView = YES;
        inDatelabel.userInteractionEnabled = YES;
        [inDatelabel addGestureRecognizer:pickInTimer];
        
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19, 23-7, 38, 14)];
        totalLabel.textColor = [UIColor blackColor];
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = [UIFont systemFontOfSize:10];
        totalLabel.layer.borderColor = PlaceHolderColor.CGColor;
        totalLabel.layer.borderWidth = 1;
        totalLabel.layer.cornerRadius = 7;
        totalLabel.layer.masksToBounds = YES;
        totalLabel.text = [NSString stringWithFormat:@"共%zi晚",self.totalDay];
        UILabel *outLabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19+38, 0, (BoundWidth-20)/2-19, InLabelHeight)];
        outLabel.textAlignment = NSTextAlignmentCenter;
        outLabel.textColor = PlaceHolderColor;
        outLabel.font = [UIFont systemFontOfSize:12];
        outLabel.text = @"离店";
        
        UILabel *outDatelabel = [[UILabel alloc] initWithFrame:CGRectMake((BoundWidth-20)/2-19+38, 21, (BoundWidth-20)/2-19, 25)];
        outDatelabel.textAlignment = NSTextAlignmentCenter;
        outDatelabel.textColor = [UIColor blackColor];
        outDatelabel.font = [UIFont systemFontOfSize:18];
        outDatelabel.text = [ProjectUtil isBlank:self.selectedEnddate]? [[NSDate date] today] : [NSString stringWithFormat:@"%@月%@日",[self.selectedEnddate substringToIndex:2],[self.selectedEnddate substringFromIndex:3]];
        
        UITapGestureRecognizer *pickOutTimer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickOutTime)];
        pickOutTimer.cancelsTouchesInView = YES;
        outDatelabel.userInteractionEnabled = YES;
        [outDatelabel addGestureRecognizer:pickOutTimer];
        
        
        [cell.contentView addSubview:inLabel];
        [cell.contentView addSubview:inDatelabel];
        [cell.contentView addSubview:totalLabel];
        [cell.contentView addSubview:outLabel];
        [cell.contentView addSubview:outDatelabel];
    }else if (indexPath.row == 2){
        UITextField *destinationTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, BoundWidth-20, CellHeight)];
        destinationTextField.textAlignment = NSTextAlignmentCenter;
        destinationTextField.textColor = [UIColor blackColor];
        destinationTextField.font = [UIFont systemFontOfSize:18];
        destinationTextField.placeholder = @"请输入酒店";
        destinationTextField.text = [ProjectUtil isNotBlank:self.hotelName] ? self.hotelName : @"";
        destinationTextField.delegate = self;
        destinationTextField.tag = 10000;
        destinationTextField.borderStyle = UITextBorderStyleNone;
        [cell.contentView addSubview:destinationTextField];
    }else{
        UILabel *starLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BoundWidth-20, CellHeight)];
        starLevelLabel.textAlignment = NSTextAlignmentCenter;
        starLevelLabel.font = [UIFont systemFontOfSize:18];
        starLevelLabel.text = [ProjectUtil isNotBlank:self.selectedResult] ? self.selectedResult : @"星级";
        starLevelLabel.textColor = [ProjectUtil isNotBlank:self.selectedResult] ? [UIColor blackColor] :PlaceHolderColor;
        [cell.contentView addSubview:starLevelLabel];
        
        UITapGestureRecognizer *starFilter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(starFilter)];
        starFilter.cancelsTouchesInView = YES;
        starLevelLabel.userInteractionEnabled = YES;
        [starLevelLabel addGestureRecognizer:starFilter];
    }

    return cell;
}


#pragma mark - button method
-(void)searchHotel{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType:andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_SearchHotel andPickedData:self.pickedData];
    }
}

-(void)locate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType:andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_Locate andPickedData:self.pickedData];
    }
}

-(void)pickInTime{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType: andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_InTime andPickedData:self.pickedData];
    }
}

-(void)pickOutTime{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType: andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_EndTime andPickedData:self.pickedData];
    }
}

-(void)autoLocate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType: andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_AutoLocate andPickedData:self.pickedData];
    }
}


-(void)starFilter{
    if (self.delegate && [self.delegate respondsToSelector:@selector(conditionPickerView:didClickWithActionType: andPickedData:)]) {
        [self.delegate conditionPickerView:self didClickWithActionType:Operation_Type_StarFilter andPickedData:self.pickedData];
    }
}

#pragma mark - setter
-(void)setCityName:(NSString *)cityName{
    if ([ProjectUtil isNotBlank:cityName]) {
        _cityName = cityName;
        [ProjectUtil saveFirstCityName:cityName];
        [_pickedData setObject:cityName forKey:@"cityName"];
        [self.tableView reloadData];
    }
}

-(void)setPickedEndTime:(NSDate *)pickedEndTime{
    _pickedEndTime = pickedEndTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    self.selectedEnddate = [dateFormatter stringFromDate:pickedEndTime];
    [_pickedData setObject:[[NSDate date] today] forKey:@"pickedStartTime"];
    [_pickedData setObject:[dateFormatter stringFromDate:pickedEndTime] forKey:@"pickedEndTime"];
    [self.tableView reloadData];
}

-(NSInteger)totalDay{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式

    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSInteger days = [[NSDate sharedInstance] calcDaysFromBegin:currentDateStr end:[dateFormat stringFromDate:self.pickedEndTime]];
    return days;
}

-(void)setDatas:(NSMutableDictionary *)datas{
    _datas  = datas;
    _selectedResult = [[NSMutableString alloc] init];
    if ([datas[@"starLevel"] integerValue] == Hotel_Star_Level_No) {
        [_selectedResult appendString:@"不限，"];
    }else if ([datas[@"starLevel"] integerValue] == Hotel_Star_Level_Cheap){
        [_selectedResult appendString:@"经济，"];
    }else if ([datas[@"starLevel"] integerValue] == Hotel_Star_Level_ThreeStar){
        [_selectedResult appendString:@"三星，"];
    }else if ([datas[@"starLevel"] integerValue] == Hotel_Star_Level_FourStar){
        [_selectedResult appendString:@"四星，"];
    }else if ([datas[@"starLevel"] integerValue] == Hotel_Star_Level_FiveStar){
        [_selectedResult appendString:@"五星，"];
    }
    
    if ([datas[@"price"] integerValue] == Hotel_Price_Level_Zero) {
        [_selectedResult appendString:@"0元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_Fifty){
        [_selectedResult appendString:@"50元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_Hundred){
        [_selectedResult appendString:@"100元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_HundredFifty){
        [_selectedResult appendString:@"150元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_TwoHundred){
        [_selectedResult appendString:@"200元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_TwoHundredFifty){
        [_selectedResult appendString:@"250元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_ThreeHundred){
        [_selectedResult appendString:@"300元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_ThreeHundredFifty){
        [_selectedResult appendString:@"350元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_FourHundred){
        [_selectedResult appendString:@"400元"];
    }else if([datas[@"price"] integerValue] == Hotel_Star_Level_NoLimit){
        [_selectedResult appendString:@"不限"];
    }
    [self.pickedData setObject:_selectedResult forKey:@"pickedLevel"];
    [self.tableView reloadData];
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
        _tableView.scrollEnabled = NO;
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

-(NSMutableDictionary *)pickedData{
    if (!_pickedData) {
        _pickedData = [NSMutableDictionary dictionary];
    }
    return _pickedData;
}

@end
