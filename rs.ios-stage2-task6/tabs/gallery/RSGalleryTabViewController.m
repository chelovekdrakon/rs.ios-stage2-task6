//
//  RSGalleryTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "RSImageInfoViewController.h"
#import "RSGalleryTabViewController.h"
#import "RSGalleryCollectionViewCell.h"

@interface RSGalleryTabViewController () <RSPhotosLibraryChangeObserver, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) RSPhotosService *photosService;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation RSGalleryTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.itemSize = [RSGalleryCollectionViewCell cellSize];
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    collectionViewLayout.minimumLineSpacing = 5.0f;
    collectionViewLayout.minimumInteritemSpacing = 5.0f;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:collectionViewLayout];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:RSGalleryCollectionViewCell.class forCellWithReuseIdentifier:[RSGalleryCollectionViewCell cellId]];
    
    [self.view addSubview:collectionView];
    
    [NSLayoutConstraint activateConstraints:@[
        [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
    self.collectionView = collectionView;
    
    self.photosService = [RSPhotosService sharedInstance];
    [self.photosService registerPhotosLibraryChangeObserver:self];
}

- (void)dealloc {
    [self.photosService unregisterPhotosLibraryChangeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.navigationItem.title = @"Gallery";
}

#pragma mark - UICollectionView Data Source

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RSGalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RSGalleryCollectionViewCell cellId] forIndexPath:indexPath];
    
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];
    cell.asset = asset;

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosService.fetchResult.count;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];
    
    RSImageInfoViewController *imageModal = [[RSImageInfoViewController alloc] initWithPHAsset:asset];
    imageModal.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self.tabBarController.navigationController pushViewController:imageModal animated:YES];
}

#pragma mark - RSPhotosLibrary Change Observer

- (void)photoLibraryDidChange:(nonnull PHFetchResultChangeDetails *)changeDetails {
    NSMutableArray *deleted = [NSMutableArray array];
    [changeDetails.removedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:1];
        [deleted addObject:indexPath];
    }];
    
    NSMutableArray *inserted = [NSMutableArray array];
    [changeDetails.insertedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:1];
        [inserted addObject:indexPath];
    }];
    
    NSMutableArray *changed = [NSMutableArray array];
    [changeDetails.changedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:1];
        [changed addObject:indexPath];
    }];
    
    if (deleted.count == 0 && inserted.count == 0 && changed.count == 0) {
        return;
    } else {
        // Workaround
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        return;
    }
    
//    typeof(self) __weak weakSelf = self;
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (@available(iOS 11.0, *)) {
//            [weakSelf.collectionView performBatchUpdates:^{
//                if (deleted.count > 0) {
//                    [weakSelf.collectionView deleteItemsAtIndexPaths:deleted];
//                }
//
//                if (inserted.count > 0) {
//                    [weakSelf.collectionView insertItemsAtIndexPaths:inserted];
//                }
//
//                if (changed.count > 0) {
//                    [weakSelf.collectionView reloadItemsAtIndexPaths:changed];
//                }
//            } completion:nil];
//        } else {
//            if (deleted.count > 0) {
//                [weakSelf.collectionView deleteItemsAtIndexPaths:deleted];
//            }
//
//            if (inserted.count > 0) {
//                [weakSelf.collectionView insertItemsAtIndexPaths:inserted];
//            }
//
//            if (changed.count > 0) {
//                [weakSelf.collectionView reloadItemsAtIndexPaths:changed];
//            }
//        }
//    });
}

@end
