//
//  RSImageInfoViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "NSString+PHAsset.h"
#import "UIColor+CustomColor.h"
#import "RSImageInfoViewController.h"


@interface RSImageInfoViewController ()
@property(nonatomic, strong) PHAsset *asset;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) PHAssetResource *resource;
@property (nonatomic, strong) RSPhotosService *photosService;
@end

@implementation RSImageInfoViewController

- (instancetype)initWithPHAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
        _photosService = [RSPhotosService sharedInstance];
        
        NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
        _resource = [resources firstObject];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentInset = UIEdgeInsetsMake(20.0f, 20.0f, 30.0f, 20.0f);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
    [self layoutScreenElementsOnScrollView:scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = self.resource.originalFilename;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
}

#pragma mark - Layout

- (void)layoutScreenElementsOnScrollView:(UIScrollView *)scrollView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.asset.pixelWidth, self.asset.pixelHeight)];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    PHImageRequestOptions *imageRequiestOptions = [[PHImageRequestOptions alloc] init];
    imageRequiestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
//    [self.photosService.imageManager requestImageForAsset:self.asset
//                                               targetSize:CGSizeMake(self.asset.pixelWidth, self.asset.pixelHeight)
//                                              contentMode:PHImageContentModeAspectFill
//                                                  options:imageRequiestOptions
//                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        if (result) {
//            imageView.image = result;
//        }
//    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss dd.MM.YYYY"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    
    // Creation date
    NSString *creationDate = [NSString stringWithFormat:@"Creation date: %@", [dateFormatter stringFromDate:self.asset.creationDate]];
    NSMutableAttributedString *creationDateString = [[NSMutableAttributedString alloc] initWithString:creationDate];
    [creationDateString addAttribute: NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 13)];
    [creationDateString addAttribute: NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(13, creationDateString.length - 13)];
    
    UILabel *creationDateLabel = [[UILabel alloc] init];
    creationDateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    creationDateLabel.textColor = [UIColor blackColor];
    creationDateLabel.attributedText = creationDateString;
    creationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // Modification date
    NSString *modificationDate = [NSString stringWithFormat:@"Modification date: %@", [dateFormatter stringFromDate:self.asset.modificationDate]];
    NSMutableAttributedString *modificationDateString = [[NSMutableAttributedString alloc] initWithString:modificationDate];
    [modificationDateString addAttribute: NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 17)];
    [modificationDateString addAttribute: NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(17, modificationDateString.length - 17)];
    
    UILabel *modificationDateLabel = [[UILabel alloc] init];
    modificationDateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    modificationDateLabel.textColor = [UIColor blackColor];
    modificationDateLabel.attributedText = modificationDateString;
    modificationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // File Type
    NSString *fileType = [NSString stringWithFormat:@"Type: %@", [NSString stringFromResourceType:self.resource.type]];
    NSMutableAttributedString *fileTypeString = [[NSMutableAttributedString alloc] initWithString:fileType];
    [fileTypeString addAttribute: NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 4)];
    [fileTypeString addAttribute: NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(4, fileTypeString.length - 4)];
    
    UILabel *fileTypeLabel = [[UILabel alloc] init];
    fileTypeLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    fileTypeLabel.textColor = [UIColor blackColor];
    fileTypeLabel.attributedText = fileTypeString;
    fileTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // Button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 275.0f, 55.0f)];
    button.layer.cornerRadius = 27.5f;
    button.backgroundColor = [UIColor yellowColor];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    [button setTitle:@"Share" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(shareFile:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:imageView];
    [scrollView addSubview:creationDateLabel];
    [scrollView addSubview:modificationDateLabel];
    [scrollView addSubview:fileTypeLabel];
    [scrollView addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:scrollView.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
        
        [creationDateLabel.topAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:38.0f],
        [creationDateLabel.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
        [creationDateLabel.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
        
        [modificationDateLabel.topAnchor constraintEqualToAnchor:creationDateLabel.bottomAnchor constant:15.0f],
        [modificationDateLabel.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
        [modificationDateLabel.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
        
        [fileTypeLabel.topAnchor constraintEqualToAnchor:modificationDateLabel.bottomAnchor constant:15.0f],
        [fileTypeLabel.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
        [fileTypeLabel.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
        
        [button.widthAnchor constraintEqualToConstant:275.0f],
        [button.heightAnchor constraintEqualToConstant:55.0f],
        [button.topAnchor constraintEqualToAnchor:fileTypeLabel.bottomAnchor constant:35.0f],
        [button.centerXAnchor constraintEqualToAnchor:scrollView.centerXAnchor],
    ]];
}

#pragma mark - Actions

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareFile:(UIButton *)button {
    NSLog(@"Share");
}


@end
