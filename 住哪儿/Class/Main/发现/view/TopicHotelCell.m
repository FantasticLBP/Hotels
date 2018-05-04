


//
//  TopicHotelCell.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/27.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "TopicHotelCell.h"
#import "TopicHotelCollectionCell.h"

static NSString *TopicHotelCollectionCellID = @"TopicHotelCollectionCell";

@interface TopicHotelCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation TopicHotelCell
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopicHotelCollectionCell" bundle:nil] forCellWithReuseIdentifier:TopicHotelCollectionCellID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subjects.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    TopicHotelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopicHotelCollectionCellID forIndexPath:indexPath];
    cell.data = self.subjects[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicHotelCell:didSelectAtIndex: andSubjectName:)]) {
        [self.delegate topicHotelCell:self didSelectAtIndex:indexPath.row+1 andSubjectName:self.subjects[indexPath.row][@"subject"]];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(130, 157);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark - setter
-(void)setSubjects:(NSMutableArray *)subjects{
    if (subjects.count != 0) {
        _subjects = subjects;
        [self.collectionView reloadData];
    }
}

@end
