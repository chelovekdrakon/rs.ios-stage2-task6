//
//  RSAnimatedViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSAnimatedFigureViewController.h"

@interface RSAnimatedFigureViewController ()
@property (nonatomic, assign, readwrite) BOOL shouldAnimate;
@end

@implementation RSAnimatedFigureViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _figureSize = 70.0f;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self stopAnimation];
}

- (void)startAnimation {
    self.shouldAnimate = YES;
}

- (void)stopAnimation {
    self.shouldAnimate = NO;
}

- (void)runAnimation {
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        if (self.shouldAnimate) {
            [self runAnimation];
        }
    }];
}

- (void)setShouldAnimate:(BOOL)shouldAnimate {
    [self willChangeValueForKey:@"shouldAnimate"];
    _shouldAnimate = shouldAnimate;
    [self didChangeValueForKey:@"shouldAnimate"];
    
    if (shouldAnimate) {
        [self runAnimation];
    }
}

@end
