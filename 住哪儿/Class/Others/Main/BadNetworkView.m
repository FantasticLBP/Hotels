

//
//  BadNetworkView.m
//  dataCube
//
//  Created by 刘斌鹏 on 2018/5/31.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "BadNetworkView.h"
#import "UIButtonBottomLine.h"
#import "BadNetworkViewController.h"

@interface BadNetworkView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButtonBottomLine *button;
@property (nonatomic, strong) UIViewController *currentViewController;
@end

@implementation BadNetworkView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.button];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.frame = CGRectMake(BoundWidth/2 - 97/2, (BoundHeight - 49 - 64)/2 - 128/2 - 60, 97, 128);
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10, BoundWidth, 21);
    self.button.frame = CGRectMake(BoundWidth/2 - 120/2, (self.frame.size.height - 49) - 70, 120, 30);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- public method

+ (BadNetworkView *)sharedInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        [instance setupUI];
    });
    return instance;
}

- (void)monitorNetwork{
     [AFNetPackage netWorkStatus];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitor:) name:NetworkingStatus object:nil];
}

#pragma mark -- reseponse method

- (void)watchNetworkSolutions{
    BadNetworkViewController *vc = [[UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"BadNetworkViewController"];
   [self.currentViewController.navigationController pushViewController:vc animated:YES];
}

- (void)monitor:(NSNotification *)notification{
    
    if ([notification.userInfo[@"NetWorkStatus"] integerValue] >= 1) {
        [self removeFromSuperview];
    }else{
        if ([UIViewController currentViewController]) {
            self.currentViewController = [UIViewController currentViewController];
            self.frame = [UIViewController currentViewController].view.bounds;
            [self layoutSubviews];
            [[UIViewController currentViewController].view addSubview:self];
        }
    }
   
}

#pragma mark -- setter && getter

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"Badnetwork_Ind"];
    }
    return _imageView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor colorFromHexCode:@"666666"];
        _label.font = [UIFont systemFontOfSize:15];
        _label.text = @"客观，请稍等，二哈把网络搞丢了";
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UIButtonBottomLine *)button{
    if (!_button) {
        _button = [UIButtonBottomLine buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"查看解决方案>>" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorFromHexCode:@"333333"]
                      forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_button addTarget:self action:@selector(watchNetworkSolutions) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
