//
//  RSGalleryCollectionViewCell.h
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSGalleryCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) PHAsset *asset;

+ (NSString *)cellId;
@end

NS_ASSUME_NONNULL_END
