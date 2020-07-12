//
//  RSGalleryTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "RSGalleryTabViewController.h"

@interface RSGalleryTabViewController () <RSPhotosLibraryChangeObserver, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSString *cellId;
@property (nonatomic, strong) RSPhotosService *photosService;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation RSGalleryTabViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellId = @"cellId";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.itemSize = CGSizeMake(118.0f, 118.0f);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:collectionViewLayout];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:self.cellId];
    
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellId forIndexPath:indexPath];
    
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];
    
    PHImageRequestOptions *imageRequiestOptions = [[PHImageRequestOptions alloc] init];
    imageRequiestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [self.photosService.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(118.0f, 118.0f)
                                contentMode:PHImageContentModeAspectFill
                                    options:imageRequiestOptions
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:result];
            [cell.contentView addSubview:imageView];
        }
    }];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosService.fetchResult.count;
}

#pragma mark - RSPhotosLibrary Change Observer

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    NSLog(@"PHChange");
}

@end
