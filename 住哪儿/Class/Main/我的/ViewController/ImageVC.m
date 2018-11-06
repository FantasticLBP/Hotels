
//  ImageVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/2.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC ()

@end

@implementation ImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight)];
    imageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:imageView];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *result ;
    if ([self.imageName isEqualToString:@"YY"]) {
        result = @"别碰杨洋老婆的手机好么？";
    }else if([self.imageName isEqualToString:@"LYF"]){
        result = @"别碰李易峰老婆的手机好么？";
    }else if([self.imageName containsString:@"XZQ"]){
        result = @"别碰薛之谦老婆的手机好么？";
    }else if([self.imageName containsString:@"ZJL"]){
        result = @"别碰周杰伦老婆的手机好么？";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告!" message:result preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"警告!"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[hogan string] length])];
    [alert setValue:hogan forKey:@"attributedTitle"];
    
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"自爆模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ok setValue:[UIColor colorWithRed:15/255.0 green:183/255.0 blue:227/255.0 alpha:1] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"自动报警" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancel setValue:[UIColor colorWithRed:15/255.0 green:183/255.0 blue:227/255.0 alpha:1] forKey:@"_titleTextColor"];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
