//
//  PhotosService.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>
#import "RSPhotosService.h"

@interface RSPhotosService () <PHPhotoLibraryChangeObserver>
@property (nonatomic, strong, readwrite) PHFetchResult<PHAsset *> *fetchResult;
@property (nonatomic, strong, readwrite) PHCachingImageManager *imageManager;

@property (nonatomic, strong) NSMutableArray<id<RSPhotosLibraryChangeObserver>> *photosLibraryChangesObservers;
@end


@implementation RSPhotosService

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.imageManager = [[PHCachingImageManager alloc] init];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[
            [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]
        ];
        self.fetchResult = [PHAsset fetchAssetsWithOptions:options];
        
        PHPhotoLibrary *photoLib = [PHPhotoLibrary sharedPhotoLibrary];
        [photoLib registerChangeObserver:self];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static RSPhotosService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RSPhotosService alloc] init];
    });
    return sharedInstance;
}

- (void)registerPhotosLibraryChangeObserver:(id<RSPhotosLibraryChangeObserver>)observer {
    [self.photosLibraryChangesObservers addObject:observer];
}

- (void)unregisterPhotosLibraryChangeObserver:(id<RSPhotosLibraryChangeObserver>)observer {
    [self.photosLibraryChangesObservers removeObject:observer];
}

#pragma mark - PHPhotoLibrary Change Observer

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    for (id<RSPhotosLibraryChangeObserver> observer in self.photosLibraryChangesObservers) {
        if ([observer conformsToProtocol:@protocol(RSPhotosLibraryChangeObserver)]) {
            [observer photoLibraryDidChange:changeInstance];
        }
    }
}

@end
