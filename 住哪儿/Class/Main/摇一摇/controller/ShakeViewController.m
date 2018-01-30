
//
//  ShakeViewController.m
//  幸运计划助手
//
//  Created by 杭城小刘 on 2017/4/30.
//  Copyright © 2017年 geek. All rights reserved.
//

#import "ShakeViewController.h"
#import "HotelDetailVC.h"
#import "HotelsModel.h"
#import "LocationManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ShakeViewController ()<LocationManagerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *hotelLabel;
@property (nonatomic, strong) UIImageView *hotelImage;
@property (nonatomic, strong) HotelsModel *model;
@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) BOOL showHotel;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self autoLocate];
}

- (void)setupUI {
    [self.view addSubview:self.imageView];
    [self becomeFirstResponder];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.hotelImage];
    [self.bgView addSubview:self.hotelLabel];
}

-(void)autoLocate{
    self.locationManager = [LocationManager sharedInstance];
    self.locationManager.delegate =  self;
    [self.locationManager autoLocate];
}

-(void)getRandomHotel{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"/controller/api/RandomHotel.php"];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"key"] = AppKey;
    paras[@"city"] = self.cityName;
    
    [SVProgressHUD showWithStatus:@"正在获取酒店数据"];
    [AFNetPackage getJSONWithUrl:url parameters:paras success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            self.model = [HotelsModel yy_modelWithJSON:dic[@"data"]];
            self.hotelLabel.text = self.model.hotelName;
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.hotelLabel.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.hotelLabel.text length])];
            self.hotelLabel.attributedText = attributedString;
            
            [self.hotelImage sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",Base_Url,self.model.image1]] placeholderImage:[UIImage imageNamed:@"jpg-1"]];
        }
    } fail:^{
        [SVProgressHUD dismiss];
    }];
}

-(void)watchDetail{
    HotelDetailVC *vc = [[HotelDetailVC alloc] init];
    vc.startPeriod = [[NSDate date] todayString];
    vc.leavePerios = [[NSDate date] GetTomorrowDayString];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LocationManagerDelegate
-(void)locationManager:(LocationManager *)locationManager didGotLocation:(NSString *)location{
    self.cityName = location;
}

#pragma mark - UIResponder
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    self.bgView.alpha = 0;
    self.bgView.hidden = YES;
    [UIView animateWithDuration:1.0 animations:^{
        [self getRandomHotel];
        self.bgView.alpha = 1;
        self.bgView.hidden = NO;
        self.hotelImage.image = [UIImage imageNamed:@"My_about"];
        self.label.text = @"您已经成功摇到一个酒店，不喜欢？换个姿势再来一次";
        [self.label sizeToFit];
        
    } completion:^(BOOL finished) {

    }];
    LBPLog(@"摇一摇开始");
    return ;
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    LBPLog(@"取消摇一摇");
    return ;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion ==UIEventSubtypeMotionShake ){
        LBPLog(@"摇一摇结束");
    }
    return ;
}

#pragma mark - lazy load
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight-60)];
        _imageView.image = [UIImage imageNamed:@"shake_news_bgVPic"];
    }
    return _imageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(BoundWidth/2-200/2, BoundHeight - 60 -300, 200, 21)];
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 2;
        _label.font = [UIFont systemFontOfSize:15];
        _label.text = @"摇一摇，为您随机推荐酒店";
        [_label sizeToFit];
    }
    return _label;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(15, BoundHeight-290, BoundWidth-30, 120)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
        _bgView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchDetail)];
        tap.cancelsTouchesInView = YES;
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(UIImageView *)hotelImage{
    if (!_hotelImage) {
        _hotelImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _hotelImage.contentMode = UIViewContentModeScaleAspectFit;
        _hotelImage.contentMode =  UIViewContentModeScaleAspectFill;
        _hotelImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _hotelImage.clipsToBounds  = YES;
    }
    return _hotelImage;
}

-(UILabel *)hotelLabel{
    if (!_hotelLabel) {
        _hotelLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, BoundWidth - 30- 140, 120)];
        _hotelLabel.textColor = [UIColor blackColor];
        _hotelLabel.numberOfLines = 0;
        _hotelLabel.font = [UIFont systemFontOfSize:20];
        _hotelLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _hotelLabel;
}
@end
