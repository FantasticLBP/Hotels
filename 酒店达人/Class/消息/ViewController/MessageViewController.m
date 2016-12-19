//
//  MessageViewController.m
//  酒店达人
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@property (nonatomic, strong) NSMutableArray *messages;     /**<消息数据源*/
@property (nonatomic, strong) UIImageView *noDataImageView; /**<没数据时显示的图片*/
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refeshUI];
}

#pragma mark - private method
-(void)refeshUI{
    if (self.messages.count == 0) {
        [self.view addSubview:self.noDataImageView];
    }
}

#pragma mark - lazy load
-(NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

-(UIImageView *)noDataImageView{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _noDataImageView.image = [UIImage imageNamed:@"function_default"];
        _noDataImageView.contentMode = UIViewContentModeCenter;
    }
    return _noDataImageView;
    
}
@end
