//
//  NSString+PHAsset.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "NSString+PHAsset.h"

@implementation NSString (PHAsset)

+ (NSString *)stringFromResourceType:(PHAssetResourceType)resourceType {
    switch (resourceType) {
        case PHAssetResourceTypePhoto: {
            return @"Image";
        }
        case PHAssetResourceTypeVideo: {
            return @"Video";
        }
        case PHAssetResourceTypeAudio: {
            return @"Audio";
        }
            
        default: {
            return @"Other";
        }
    }
}

@end
