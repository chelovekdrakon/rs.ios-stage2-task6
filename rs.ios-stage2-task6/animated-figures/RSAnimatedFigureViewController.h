//
//  RSAnimatedViewController.h
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAnimatedFigureViewController : UIViewController

@property (nonatomic, assign, readonly) int figureSize;
@property (nonatomic, assign, readonly) BOOL shouldAnimate;

- (instancetype)initWithSize:(int)size;

@end

NS_ASSUME_NONNULL_END
