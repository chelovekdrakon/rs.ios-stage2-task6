//
//  RSGalleryCollectionViewCell.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "RSGalleryCollectionViewCell.h"

@interface RSGalleryCollectionViewCell()
@property (nonatomic, strong) RSPhotosService *photosService;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation RSGalleryCollectionViewCell

+ (CGSize)cellSize {
    return CGSizeMake(118.0f, 118.0f);
}

+ (NSString *)cellId {
    return @"RSGalleryCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118.0f, 118.0f)];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        self.photosService = [RSPhotosService sharedInstance];
    }
    return self;
}

- (void)setAsset:(PHAsset *)asset {
    [self willChangeValueForKey:@"asset"];
    
    PHImageRequestOptions *imageRequiestOptions = [[PHImageRequestOptions alloc] init];
    imageRequiestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [self.photosService.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(118.0f, 118.0f)
                                contentMode:PHImageContentModeAspectFill
                                    options:imageRequiestOptions
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            self.imageView.image = result;
        }
    }];
    
    [self didChangeValueForKey:@"asset"];
}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

@end
