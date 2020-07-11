//
//  RSCircleViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSAnimatedCircleViewController.h"
#import "UIColor+CustomColor.h"

@interface RSAnimatedCircleViewController ()

@end

@implementation RSAnimatedCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, self.figureSize, self.figureSize);
    self.view.layer.cornerRadius = self.figureSize / 2;
    self.view.backgroundColor = [UIColor redColor];
    
//    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
//    anim.keyPath = @"transform.scale";
//
//    anim.values = @[@(0.9), @(1), @(1.1), @(1)];
//    anim.keyTimes = @[@(0), @(0.5), @(1), @(1.5)];
//    anim.duration = 1.5;
//    anim.repeatCount = INFINITY;
//
//    [self.view.layer addAnimation:anim forKey:nil];
}

- (void)runAnimation {
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        // -10%
        self.view.transform = CGAffineTransformScale(self.view.transform, 0.9, 0.9);
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            // back to normal
            self.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {

            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                // +10%
                self.view.transform = CGAffineTransformScale(self.view.transform, 1.1, 1.1);
            } completion:^(BOOL finished) {

                [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                    // back to normal
                    self.view.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {

                    if (self.shouldAnimate) {
                        // run again
                        [self runAnimation];
                    }

                }];

            }];

        }];

    }];
}

@end
