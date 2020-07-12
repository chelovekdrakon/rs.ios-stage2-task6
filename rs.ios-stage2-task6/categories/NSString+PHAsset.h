//
//  NSString+PHAsset.h
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PHAsset)
+ (NSString *)stringFromResourceType:(PHAssetResourceType)resourceType;
@end

NS_ASSUME_NONNULL_END
