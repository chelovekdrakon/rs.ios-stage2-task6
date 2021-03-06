//
//  RSInfoTableViewCell.h
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/12/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSInfoTableViewCell : UITableViewCell
@property(nonatomic, strong) PHAsset *asset;

+ (CGSize)cellSize;
+ (NSString *)cellId;
@end

NS_ASSUME_NONNULL_END
