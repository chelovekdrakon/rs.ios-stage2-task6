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
@end

@implementation RSGalleryCollectionViewCell

+ (NSString *)cellId {
    return @"RSGalleryCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
            UIImageView *imageView = [[UIImageView alloc] initWithImage:result];
            [self.contentView addSubview:imageView];
        }
    }];
    
    [self didChangeValueForKey:@"asset"];
}

- (void)prepareForReuse {
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

@end
