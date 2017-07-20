

//
//  HotelAlbumsVC.m
//  住哪儿
//
//  Created by 杭城小刘 on 2016/12/25.
//  Copyright © 2016年 geek. All rights reserved.
//

#import "HotelAlbumsVC.h"
#import "HotelDetailImageCell.h"
#import "MWPhotoBrowser.h"


static NSString *HotelDetailImageCellID = @"HotelDetailImageCell";


@interface HotelAlbumsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,
                            MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *photos;        /**< 图片浏览器展示图片数组*/

@end

@implementation HotelAlbumsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private method
-(void)setupUI{
    self.title = @"酒店图片";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

}

#pragma mark -- MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return  self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageDatas.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                 cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    HotelDetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotelDetailImageCellID forIndexPath:indexPath];
    cell.imageName = self.imageDatas[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.photos = nil;
    for (NSString *imageName in self.imageDatas) {
        if ([ProjectUtil isNotBlank:imageName]) {
            UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
            [self.photos addObject:[MWPhoto photoWithImage:tempImage]];
        }
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    [browser setCurrentPhotoIndex:indexPath.row];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:browser];
    [browser.navigationController.navigationBar setTitleTextAttributes:  @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - lazy load
-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout* layout =
        [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((BoundWidth-5 )/ 4, (BoundWidth-5 ) / 4);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout ];
        collect.scrollEnabled = NO;
        collect.backgroundColor = [UIColor whiteColor];
        collect.delegate = self;
        collect.dataSource = self;
        [collect registerNib:[UINib nibWithNibName:@"HotelDetailImageCell" bundle:nil] forCellWithReuseIdentifier:HotelDetailImageCellID];
        _collectionview = collect;
    }
    return _collectionview;
}

-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end
