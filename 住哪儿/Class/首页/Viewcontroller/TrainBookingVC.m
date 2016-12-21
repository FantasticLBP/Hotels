

//
//  TrainBookingVC.m
//  住哪儿
//
//  Created by geek on 2016/12/18.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TrainBookingVC.h"

@interface TrainBookingVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation TrainBookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车票预订";
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.path]]];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark - lazy load
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

@end
