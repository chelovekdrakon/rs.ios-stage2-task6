//
//  PhotosService.h
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>
#import <Foundation/Foundation.h>

@protocol RSPhotosLibraryChangeObserver <NSObject>
- (void)photoLibraryDidChange:(PHChange *)changeInstance;
@end

NS_ASSUME_NONNULL_BEGIN

@interface RSPhotosService : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) PHCachingImageManager *imageManager;
@property (nonatomic, strong, readonly) PHFetchResult<PHAsset *> *fetchResult;

- (void)registerPhotosLibraryChangeObserver:(id<RSPhotosLibraryChangeObserver>)observer;
- (void)unregisterPhotosLibraryChangeObserver:(id<RSPhotosLibraryChangeObserver>)observer;

@end

NS_ASSUME_NONNULL_END
