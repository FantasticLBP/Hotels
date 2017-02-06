//
//  LiuXSlider.m
//  LJSlider
//
//  Created by 刘鑫 on 16/3/24.
//  Copyright © 2016年 com.anjubao. All rights reserved.
//

//  git地址：https://github.com/xinge1/LiuXSlider
//



#define SelectViewBgColor   [UIColor colorWithRed:9/255.0 green:170/255.0 blue:238/255.0 alpha:1]
#define defaultViewBgColor  [UIColor lightGrayColor]

#define LiuXSlideWidth      (self.bounds.size.width)
#define LiuXSliderHight     (self.bounds.size.height)

#define LiuXSliderTitle_H   (LiuXSliderHight*.3)

#define CenterImage_W       26.0

#define LiuXSliderLine_W    (LiuXSlideWidth-CenterImage_W)
#define LiuXSLiderLine_H    6.0
#define LiuXSliderLine_Y    (LiuXSliderHight-LiuXSliderTitle_H)


#define CenterImage_Y       (LiuXSliderLine_Y+(LiuXSLiderLine_H/2))


#import "LiuXSlider.h"

@interface LiuXSlider()
{

    CGFloat _pointX;
    NSInteger _sectionIndex;//当前选中的那个
    CGFloat _sectionLength;//根据数组分段后一段的长度
    UILabel *_selectLab;
    UILabel *_leftLab;
    UILabel *_rightLab;
}
/**
 *  必传，范围（0到(array.count-1)）
 */
@property (nonatomic,assign)CGFloat defaultIndx;

/**
 *  必传，传入节点数组
 */
@property (nonatomic,strong)NSArray *titleArray;

/**
 *  首，末位置的title
 */
@property (nonatomic,strong)NSArray *firstAndLastTitles;
/**
 *  传入图片
 */
@property (nonatomic,strong)UIImage *sliderImage;

@property (strong,nonatomic)UIView *selectView;

@property (strong,nonatomic)UIView *defaultView;
@property (strong,nonatomic)UIImageView *startImage;

@end

@implementation LiuXSlider


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray firstAndLastTitles:(NSArray *)firstAndLastTitles defaultIndex:(CGFloat)defaultIndex sliderImage:(UIImage *)sliderImage
{
    if (self  = [super initWithFrame:frame]) {
        _pointX=0;
        _sectionIndex=0;
        
        self.backgroundColor=[UIColor clearColor];
        
        _defaultView=[[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, LiuXSliderLine_Y, LiuXSlideWidth-CenterImage_W, LiuXSLiderLine_H)];
        _defaultView.backgroundColor=defaultViewBgColor;
        _defaultView.layer.cornerRadius=LiuXSLiderLine_H/2;
        _defaultView.userInteractionEnabled=NO;
        [self addSubview:_defaultView];
        
        _selectView=[[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, LiuXSliderLine_Y, LiuXSlideWidth-CenterImage_W, LiuXSLiderLine_H)];
        _selectView.backgroundColor=SelectViewBgColor;
        _selectView.layer.cornerRadius=LiuXSLiderLine_H/2;
        _selectView.userInteractionEnabled=NO;
        [self addSubview:_selectView];
        
        _startImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CenterImage_W, CenterImage_W)];
        _startImage.center=CGPointMake(0, CenterImage_Y);
        _startImage.userInteractionEnabled=NO;
        _startImage.alpha=.5;
        [self addSubview:_startImage];
        

        _selectLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        _selectLab.textColor=[UIColor blackColor];
        _selectLab.font=[UIFont systemFontOfSize:14];
        _selectLab.textAlignment=1;
        [self addSubview:_selectLab];
        
        self.titleArray=titleArray;
        self.defaultIndx=defaultIndex;
        self.firstAndLastTitles=firstAndLastTitles;
        self.sliderImage=sliderImage;
    }
    return self;
}


-(void)setDefaultIndx:(CGFloat)defaultIndx{
    CGFloat withPress=defaultIndx/(_titleArray.count-1);
    //设置默认位置
    CGRect rect=[_selectView frame];
    rect.size.width = withPress*LiuXSliderLine_W;
    _selectView.frame=rect;
    
    _pointX=withPress*LiuXSliderLine_W;
    _sectionIndex=defaultIndx;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray=titleArray;
    _sectionLength=(LiuXSliderLine_W/(titleArray.count-1));
}

-(void)setFirstAndLastTitles:(NSArray *)firstAndLastTitles{
    _leftLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 80, LiuXSliderTitle_H)];
    _leftLab.font=[UIFont systemFontOfSize:12];
    _leftLab.textColor=[UIColor lightGrayColor];
    _leftLab.text=[firstAndLastTitles firstObject];
    [self addSubview:_leftLab];
    
    _rightLab=[[UILabel alloc] initWithFrame:CGRectMake(LiuXSlideWidth-80, 10, 80, LiuXSliderTitle_H)];
    _rightLab.font=[UIFont systemFontOfSize:12];
    _rightLab.textColor=[UIColor lightGrayColor];
    _rightLab.text=[firstAndLastTitles lastObject];
    _rightLab.textAlignment=2;
    [self addSubview:_rightLab];
    
}

-(void)setSliderImage:(UIImage *)sliderImage{
    _startImage.image=sliderImage;
    
    [self refreshSlider];
}


#pragma mark ---UIColor Touchu
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    _pointX=_sectionIndex*(_sectionLength);
    [self refreshSlider];
    [self labelEnlargeAnimation];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    _pointX=_sectionIndex*(_sectionLength);
    if (self.block) {
        self.block((int)_sectionIndex);
    }
    [self refreshSlider];
    [self labelLessenAnimation];
    
}

-(void)changePointX:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    _pointX=point.x;
    if (point.x<0) {
        _pointX=CenterImage_W/2;
    }else if (point.x>LiuXSliderLine_W){
        _pointX=LiuXSliderLine_W+CenterImage_W/2;
    }
    //四舍五入计算选择的节点
    _sectionIndex=(int)roundf(_pointX/_sectionLength);
}

-(void)refreshSlider{
    _pointX=_pointX+CenterImage_W/2;
    _startImage.center=CGPointMake(_pointX, CenterImage_Y);
    
    
    
    CGRect rect = [_selectView frame];
    rect.size.width=_pointX-CenterImage_W/2;
    _selectView.frame=rect;
    
    _selectLab.text=[NSString stringWithFormat:@"%@",_titleArray[_sectionIndex]];
    if (_sectionIndex==0) {
        _leftLab.hidden=YES;
        _selectLab.center=CGPointMake(_pointX, 10);
    }else if (_sectionIndex==_titleArray.count-1) {
        _rightLab.hidden=YES;
        _selectLab.center=CGPointMake(_pointX, 10);
    }else{
        _leftLab.hidden=NO;
        _rightLab.hidden=NO;
        _selectLab.center=CGPointMake(_pointX, 7);
    }
    
}

-(void)labelEnlargeAnimation{
    [UIView animateWithDuration:.1 animations:^{
        [_selectLab.layer setValue:@(1.4) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)labelLessenAnimation{
    [UIView animateWithDuration:.1 animations:^{
        [_selectLab.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        
    }];
}

@end
