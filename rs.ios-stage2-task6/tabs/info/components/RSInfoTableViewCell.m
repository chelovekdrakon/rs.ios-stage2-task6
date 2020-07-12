//
//  RSInfoTableViewCell.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSPhotosService.h"
#import "RSInfoTableViewCell.h"
#import "UIColor+CustomColor.h"

@interface RSInfoTableViewCell()
@property (nonatomic, strong) RSPhotosService *photosService;
@property (nonatomic, strong) NSDateFormatter *durationDateFormatter;
@end

@implementation RSInfoTableViewCell

+ (CGSize)cellSize {
    return CGSizeMake(75.0f, 75.0f);
}

+ (NSString *)cellId {
    return @"RSInfoTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor yellowHighlightedColor];
        [self setSelectedBackgroundView:bgColorView];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        
        _durationDateFormatter = dateFormatter;
        
        self.photosService = [RSPhotosService sharedInstance];
        
        self.textLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightRegular];
    }
    return self;
}

- (void)setAsset:(PHAsset *)asset {
    [self willChangeValueForKey:@"asset"];
    
    PHImageRequestOptions *imageRequiestOptions = [[PHImageRequestOptions alloc] init];
    imageRequiestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [self.photosService.imageManager requestImageForAsset:asset
                                 targetSize:[RSInfoTableViewCell cellSize]
                                contentMode:PHImageContentModeAspectFill
                                    options:imageRequiestOptions
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            self.imageView.image = result;
        }
    }];
    
    NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
    NSString *fileName = ((PHAssetResource*)resources[0]).originalFilename;
    
    self.textLabel.text = fileName;
    
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

    self.detailTextLabel.attributedText = subTitle;
    
    [self didChangeValueForKey:@"asset"];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    self.textLabel.text = @"";
    self.detailTextLabel.attributedText = [[NSAttributedString alloc] init];
}

@end
