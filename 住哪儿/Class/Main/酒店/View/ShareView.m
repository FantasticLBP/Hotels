
//
//  ShareView.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/20.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "ShareView.h"
#import "ShareCollectionCell.h"

#define CloseButtonHeight 50
#define BoundaryViewHeight 1

static NSString *ShareCollectionCellID = @"ShareCollectionCell";


@interface ShareView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *boundaryView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shareImageIcons;
@end

@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.boundaryView];
    [self addSubview:self.closeButton];
    [self addSubview:self.collectionView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    [self.boundaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(BoundaryViewHeight);
        make.bottom.mas_equalTo(-CloseButtonHeight);
    }];
    
    
    
    
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(CloseButtonHeight);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(self.frame.size.height - BoundaryViewHeight -CloseButtonHeight);
    }];
    [self.collectionView reloadData];
}

#pragma mark - button method
-(void)closeShareView{
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:CGRectMake(0, BoundHeight, BoundWidth, self.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shareImageIcons.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShareCollectionCellID forIndexPath:indexPath];
    cell.imageName = self.shareImageIcons[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.frame.size.width-0)/4, (self.frame.size.height-51)/2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectItemAtIndexPath:)]) {
        [self.delegate shareView:self didSelectItemAtIndexPath:indexPath.row];
    }
}

#pragma mark - lazy load
-(UIView *)boundaryView{
    if (!_boundaryView) {
        _boundaryView = [[UIView alloc] initWithFrame:CGRectZero];
        _boundaryView.backgroundColor = CollectionViewBackgroundColor;
    }
    return _boundaryView;
}

-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor clearColor];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeShareView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.frame.size.width-0)/4, (self.frame.size.height-51)/2);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collect registerNib:[UINib nibWithNibName:@"ShareCollectionCell" bundle:nil] forCellWithReuseIdentifier:ShareCollectionCellID];
        collect.scrollEnabled = NO;
        collect.backgroundColor = [UIColor whiteColor];
        collect.delegate = self;
        collect.dataSource = self;
        _collectionView = collect;
    }
    return _collectionView;
}

-(NSMutableArray *)shareImageIcons{
    if (!_shareImageIcons) {
        NSArray *array = @[@"Share_weixin_friends",@"Share_weixin_circle",@"Share_sina",@"Share_qq_icon",@"Share_qq_zone_icon",@"Share_message"];
        _shareImageIcons = [NSMutableArray arrayWithArray:array];
    }
    return _shareImageIcons;
}
@end
