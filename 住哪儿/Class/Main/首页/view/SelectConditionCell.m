
//
//  SelectConditionCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/9.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "SelectConditionCell.h"
#import "ConditionCell.h"

static NSString *ConditionCellID = @"ConditionCell";

@interface SelectConditionCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation SelectConditionCell

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
    ConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ConditionCellID forIndexPath:indexPath];
    NSDictionary *dic = self.datas[indexPath.row];
    cell.imageName = dic[@"image"];
    cell.titleName = dic[@"title"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(selectConditionCell:didClickCollectionCellAtIndexPath:)]) {
        [self.delegate selectConditionCell:self didClickCollectionCellAtIndexPath:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(BoundWidth/4, 90);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - lazy load
-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout* layout =
        [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(BoundWidth / 4, (self.frame.size.height-1)/2);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, BoundWidth, 180) collectionViewLayout:layout ];
        collect.scrollEnabled = NO;
        collect.backgroundColor = [UIColor whiteColor];
        collect.delegate = self;
        collect.dataSource = self;
        [collect registerNib:[UINib nibWithNibName:@"ConditionCell" bundle:nil] forCellWithReuseIdentifier:ConditionCellID];
        _collectionview = collect;
    }
    return _collectionview;
}


-(void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    if (datas.count > 0) {
        [self.collectionview reloadData];
    }
}
@end
