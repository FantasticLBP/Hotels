//
//  CDatePickerViewEx.m
//  Textfield输入
//
//  Created by geek on 2016/10/17.
//  Copyright © 2016年 geek. All rights reserved.
//


#import "CDatePickerViewEx.h"


// Identifiers of components
//#define MONTH ( 0 )
#define YEAR ( 0 )


// Identifies for component views
#define LABEL_TAG 43


@interface CDatePickerViewEx()

@property (nonatomic, strong) NSIndexPath *todayIndexPath;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *years;

-(NSArray *)nameOfYears;
-(NSArray *)nameOfMonths;
-(CGFloat)componentWidth;

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected;
-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component;
-(NSIndexPath *)todayPath;
-(NSInteger)bigRowMonthCount;
-(NSInteger)bigRowYearCount;
-(NSString *)currentMonthName;
-(NSString *)currentYearName;

@end



@implementation CDatePickerViewEx

const NSInteger bigRowCount = 1000;
const NSInteger minYear = 2008;
const NSInteger maxYear = 2030;
const CGFloat rowHeight = 44.f;
const NSInteger numberOfComponents = 1;

@synthesize todayIndexPath;
@synthesize months;
@synthesize years = _years;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.years = [self nameOfYears];
    self.todayIndexPath = [self todayPath];
    
    self.delegate = self;
    self.dataSource = self;
    
    [self selectToday];
}

-(NSDate *)date
{
//    NSInteger monthCount = [self.months count];
//    NSString *month = [self.months objectAtIndex:([self selectedRowInComponent:MONTH] % monthCount)];
    
    NSInteger yearCount = [self.years count];
    NSString *year = [self.years objectAtIndex:([self selectedRowInComponent:YEAR] % yearCount)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"Myyyy"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@", year]];
    return date;
}

#pragma mark - UIPickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [self componentWidth];
}

-(UIView *)pickerView: (UIPickerView *)pickerView
           viewForRow: (NSInteger)row
         forComponent: (NSInteger)component
          reusingView: (UIView *)view
{
    
    BOOL selected = NO;

//    NSInteger yearCount = [self.years count];
//    NSString *yearName = [self.years objectAtIndex:(row % yearCount)];
//    NSString *currenrYearName  = [NSString stringWithFormat:@"%@年", [self currentYearName]];
//    if([yearName isEqualToString:[NSString stringWithFormat:@"%@年", self.year]] == YES)
//    {
//        selected = YES;
//    }

    
    UILabel *returnView = nil;
    if(view.tag == LABEL_TAG)
    {
        returnView = (UILabel *)view;
    }
    else
    {
        returnView = [self labelForComponent: component selected: selected];
    }
    
    returnView.textColor = selected ? [UIColor blueColor] : [UIColor blackColor];
    returnView.text = [self titleForRow:row forComponent:component];
    
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return rowHeight;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self bigRowYearCount];
}

#pragma mark - Util

-(NSInteger)bigRowYearCount
{
    return [self.years count]  * bigRowCount;
}

-(CGFloat)componentWidth
{
    return self.bounds.size.width / numberOfComponents;
}

-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSInteger yearCount = [self.years count];
    return [self.years objectAtIndex:(row % yearCount)];
}

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected
{
    CGRect frame = CGRectMake(0.f, 0.f, [self componentWidth],rowHeight);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = selected ? [UIColor blueColor] : [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18.f];
    label.userInteractionEnabled = NO;
    [label setText:self.year];
//    label.text = [NSString stringWithFormat:@"%@年", self.year];
    label.tag = LABEL_TAG;
    
    
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *year = @"";
    if (row >= 11500) {
        year = [NSString stringWithFormat:@"%ld", 2008 + (row - 11500)-((row - 11500)/23)*23];
    }else{
        year = [NSString stringWithFormat:@"%ld", 2008 + 23 - ((11500-row)-((11500 - row)/23)*23)];
    }
    

    self.year = year;
    
    
}

//-(NSArray *)nameOfMonths
//{
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    return [dateFormatter standaloneMonthSymbols];
//}

-(NSArray *)nameOfYears
{
    NSMutableArray *years = [NSMutableArray array];
    
    for(NSInteger year = minYear; year <= maxYear; year++)
    {
        NSString *yearStr = [NSString stringWithFormat:@"%li年", (long)year];
        [years addObject:yearStr];
    }
    return years;
}

-(void)selectToday
{
//    [self selectRow: self.todayIndexPath.row
//        inComponent: MONTH
//           animated: NO];
    
    [self selectRow: self.todayIndexPath.row
        inComponent: YEAR
           animated: NO];
}

-(NSIndexPath *)todayPath // row - month ; section - year
{
    CGFloat row = 0.f;
    CGFloat section = 0.f;
    
//    NSString *month = [self currentMonthName];
    NSString *year  = [NSString stringWithFormat:@"%@年", [self currentYearName]];
    
    //set table on the middle
//    for(NSString *cellMonth in self.months)
//    {
//        if([cellMonth isEqualToString:month])
//        {
//            row = [self.months indexOfObject:cellMonth];
//            row = row + [self bigRowMonthCount] / 2;
//            break;
//        }
//    }
    
    for(NSString *cellYear in self.years)
    {
        if([cellYear isEqualToString:year])
        {
            row = [self.years indexOfObject:cellYear];
            row = row + [self bigRowYearCount] / 2;
            break;
        }
    }
    
    return [NSIndexPath indexPathForRow:row inSection:row];
}

//-(NSString *)currentMonthName
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMMM"];
//    return [formatter stringFromDate:[NSDate date]];
//}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
