//
//  OrderViewController.m
//  住哪儿
//
//  Created by geek on 2016/10/10.
//  Copyright © 2016年 Fantasticbaby. All rights reserved.
//

#import "OrderViewController.h"
#import "LBPScrollSegmentView.h"
#import "OrderItemVC.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,
                                    LBPcrollSegmentViewDelegate>
@property (nonatomic, strong) LBPScrollSegmentView *scrollSegmentView;              /**<选择view*/
@property (nonatomic ,strong) OrderItemVC *willPayVC;                   /**<待付款*/
@property (nonatomic ,strong) OrderItemVC *unWalkVC;                    /**<未出行*/
@property (nonatomic ,strong) OrderItemVC *willEvaluateVC;              /**<待评价*/
@property (nonatomic ,strong) OrderItemVC *historyVC;                   /**<历史*/
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
        item.image = [UIImage imageNamed:@"small_icon_phone"];
        item.target = self;
        item.action = @selector(clickContactPhone);
         item;
    });
    
    [self.view addSubview:self.scrollSegmentView];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - private method
-(void)clickContactPhone{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打客服电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *tel = [UIAlertAction actionWithTitle:TelePhoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * telUrl = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",TelePhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
    }];
    [alert addAction:tel];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}



#pragma mark - lazy load
-(OrderItemVC *)willPayVC{
    if (!_willPayVC) {
        _willPayVC = [[OrderItemVC alloc] init];
        _willPayVC.type = OrderType_WillPay;
    }
    return _willPayVC;
}

-(OrderItemVC *)unWalkVC{
    if (!_unWalkVC) {
        _unWalkVC = [[OrderItemVC alloc] init];
        _unWalkVC.type = OrderType_UnWalk;
    }
    return _unWalkVC;
}

-(OrderItemVC *)willEvaluateVC{
    if (!_willEvaluateVC) {
        _willEvaluateVC = [[OrderItemVC alloc] init];
        _willEvaluateVC.type = OrderType_UnEvaluate;
    }
    return _willEvaluateVC;
}

-(OrderItemVC *)historyVC{
    if (!_historyVC) {
        _historyVC = [[OrderItemVC alloc] init];
        _historyVC.type = OrderType_History;
    }
    return _historyVC;
}

- (LBPScrollSegmentView *)scrollSegmentView {
    if (!_scrollSegmentView) {
        _scrollSegmentView = [[LBPScrollSegmentView alloc] initWithFrame:CGRectMake(0,0, BoundWidth, BoundHeight ) delegate:self titlesGroup:@[@"待付款",@"未出行",@"待评价",@"历史记录"] controllersGroup:@[self.willPayVC,self.unWalkVC,self.willEvaluateVC,self.historyVC]];
    }
    return _scrollSegmentView;
}
@end
