//
//  RSInfoTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>

#import "RSPhotosService.h"
#import "UIColor+CustomColor.h"
#import "RSInfoTabViewController.h"

@interface RSInfoTabViewController () <UITableViewDelegate, UITableViewDataSource, RSPhotosLibraryChangeObserver>
@property (nonatomic, strong) NSString *cellId;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSPhotosService *photosService;
@property (nonatomic, strong) NSDateFormatter *durationDateFormatter;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@end

@implementation RSInfoTabViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellId = @"cellId";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        
        _durationDateFormatter = dateFormatter;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:self.cellId];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    self.imageManager = [[PHCachingImageManager alloc] init];
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellId];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor yellowHighlightedColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    PHAsset *asset = self.photosService.fetchResult[indexPath.row];
    
    PHImageRequestOptions *imageRequiestOptions = [[PHImageRequestOptions alloc] init];
    imageRequiestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [self.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(75.0f, 75.0f)
                                contentMode:PHImageContentModeAspectFill
                                    options:imageRequiestOptions
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            cell.imageView.image = result;
        }
    }];
    
    NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
    NSString *fileName = ((PHAssetResource*)resources[0]).originalFilename;
    
    cell.textLabel.text = fileName;
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
    
    NSMutableString *subTitleText = [[NSMutableString alloc] init];
    NSTextAttachment *attachmentImage = [[NSTextAttachment alloc] init];
    NSMutableAttributedString *subTitle= [[NSMutableAttributedString alloc] init];
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage: {
            attachmentImage.image = [UIImage imageNamed:@"image"];
            [subTitleText appendString:[NSString stringWithFormat:@" %@x%@", @(asset.pixelWidth), @(asset.pixelHeight)]];
            break;
        }
        case PHAssetMediaTypeVideo: {
            attachmentImage.image = [UIImage imageNamed:@"video"];
            NSDate *durationDate = [NSDate dateWithTimeIntervalSince1970:asset.duration];
            [subTitleText appendString:[NSString stringWithFormat:@" %@x%@, %@ sec", @(asset.pixelWidth), @(asset.pixelHeight), [self.durationDateFormatter stringFromDate:durationDate]]];
            break;
        }
        case PHAssetMediaTypeAudio: {
            attachmentImage.image = [UIImage imageNamed:@"audio"];
            NSDate *durationDate = [NSDate dateWithTimeIntervalSince1970:asset.duration];
            [subTitleText appendString:[NSString stringWithFormat:@" %@", [self.durationDateFormatter stringFromDate:durationDate]]];
            break;
        }
        default: {
            attachmentImage.image = [UIImage imageNamed:@"other"];
            break;
        }
    }

    NSAttributedString *subTitleImage = [NSAttributedString attributedStringWithAttachment:attachmentImage];
    
    [subTitle appendAttributedString:subTitleImage];
    [subTitle appendAttributedString:[[NSMutableAttributedString alloc] initWithString:subTitleText]];
    
    [subTitle addAttribute:NSBaselineOffsetAttributeName value:@(6) range:NSMakeRange(subTitleImage.length, subTitleText.length)];
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    [subTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, subTitleText.length)];

    cell.detailTextLabel.attributedText = subTitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
    
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
