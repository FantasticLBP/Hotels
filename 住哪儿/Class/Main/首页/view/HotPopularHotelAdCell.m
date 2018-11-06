

//
//  HotPopularHotelAdCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotPopularHotelAdCell.h"
#import "HotPopularHotelCollectionCell.h"

static NSString *HotPopularHotelCollectionCellID = @"HotPopularHotelCollectionCell";

@interface HotPopularHotelAdCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation HotPopularHotelAdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - private method
-(void)setupUI{
    [self addSubview:self.collectionview];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionview reloadData];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    HotPopularHotelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotPopularHotelCollectionCellID forIndexPath:indexPath];
    NSDictionary *dic = self.datas[indexPath.row];
    cell.imageName = dic[@"image"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HotPopularHotelAdCell:didClickCollectionCellAtIndexPath:)]) {
        [self.delegate HotPopularHotelAdCell:self didClickCollectionCellAtIndexPath:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(BoundWidth/3, 106);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collection:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  0;
}

#pragma mark - lazy load
-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout* layout =
        [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(BoundWidth/3, self.frame.size.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, BoundWidth *2, 106) collectionViewLayout:layout ];
        collect.scrollEnabled = YES;
        collect.showsHorizontalScrollIndicator = NO;
        collect.backgroundColor = CollectionViewBackgroundColor;
        collect.delegate = self;
        collect.dataSource = self;
        [collect registerNib:[UINib nibWithNibName:@"HotPopularHotelCollectionCell" bundle:nil] forCellWithReuseIdentifier:HotPopularHotelCollectionCellID];
        _collectionview = collect;
    }
    return _collectionview;
}

@end
