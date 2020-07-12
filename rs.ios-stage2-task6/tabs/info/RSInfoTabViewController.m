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

#pragma mark - RSPhotosLibrary Change Observer

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    NSLog(@"PHChange");
}

@end
