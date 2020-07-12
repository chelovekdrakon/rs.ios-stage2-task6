//
//  RSInfoTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "UIColor+CustomColor.h"
#import "RSInfoTableViewCell.h"
#import "RSInfoTabViewController.h"
#import "RSImageInfoViewController.h"

@interface RSInfoTabViewController () <UITableViewDelegate, UITableViewDataSource, RSPhotosLibraryChangeObserver>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSPhotosService *photosService;
@end

@implementation RSInfoTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView registerClass:RSInfoTableViewCell.class forCellReuseIdentifier:[RSInfoTableViewCell cellId]];
    
    [self.view addSubview:tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
    self.tableView = tableView;

    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]
    ];
    self.photosService = [RSPhotosService sharedInstance];
    
    [self.photosService registerPhotosLibraryChangeObserver:self];
}

- (void)dealloc {
    [self.photosService unregisterPhotosLibraryChangeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.navigationItem.title = @"Info";
}

#pragma mark - UITableView Data Source

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RSInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSInfoTableViewCell cellId] forIndexPath:indexPath];
    
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];    
    cell.asset = asset;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photosService.fetchResult.count;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];
    
    RSImageInfoViewController *imageModal = [[RSImageInfoViewController alloc] initWithPHAsset:asset];
    imageModal.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self.tabBarController.navigationController pushViewController:imageModal animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - RSPhotosLibrary Change Observer

- (void)photoLibraryDidChange:(nonnull PHFetchResultChangeDetails *)changeDetails {    
    NSMutableArray *deleted = [NSMutableArray array];
    [changeDetails.removedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:1];
        [deleted addObject:indexPath];
    }];
    
    NSMutableArray *inserted = [NSMutableArray array];
    [changeDetails.insertedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:1];
        [inserted addObject:indexPath];
    }];
    
    NSMutableArray *changed = [NSMutableArray array];
    [changeDetails.changedIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:1];
        [changed addObject:indexPath];
    }];
    
    if (deleted.count == 0 && inserted.count == 0 && changed.count == 0) {
        return;
    } else {
        // Workaround
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        return;
    }
    
//    typeof(self) __weak weakSelf = self;
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (@available(iOS 11.0, *)) {
//            [weakSelf.tableView performBatchUpdates:^{
//                if (deleted.count > 0) {
//                    [weakSelf.tableView deleteRowsAtIndexPaths:deleted withRowAnimation:UITableViewRowAnimationLeft];
//                }
//
//                if (inserted.count > 0) {
//                    [weakSelf.tableView insertRowsAtIndexPaths:inserted withRowAnimation:UITableViewRowAnimationRight];
//                }
//
//                if (changed.count > 0) {
//                    [weakSelf.tableView reloadRowsAtIndexPaths:changed withRowAnimation:UITableViewRowAnimationNone];
//                }
//            } completion:nil];
//        } else {
//            [weakSelf.tableView beginUpdates];
//
//            if (deleted.count > 0) {
//                [weakSelf.tableView deleteRowsAtIndexPaths:deleted withRowAnimation:UITableViewRowAnimationLeft];
//            }
//
//            if (inserted.count > 0) {
//                [weakSelf.tableView insertRowsAtIndexPaths:inserted withRowAnimation:UITableViewRowAnimationRight];
//            }
//
//            if (changed.count > 0) {
//                [weakSelf.tableView reloadRowsAtIndexPaths:changed withRowAnimation:UITableViewRowAnimationNone];
//            }
//
//            [weakSelf.tableView endUpdates];
//        }
//    });
}

@end
