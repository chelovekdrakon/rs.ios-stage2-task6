//
//  RSSquareViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSAnimatedSquareViewController.h"
#import "UIColor+CustomColor.h"

@interface RSAnimatedSquareViewController ()

@end

@implementation RSAnimatedSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, self.figureSize, self.figureSize);
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)runAnimation {
    float movementDistance = self.figureSize / 10;
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        // -10%
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0.0f, -movementDistance);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            // back to normal
            self.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
                // +10%
                self.view.transform = CGAffineTransformTranslate(self.view.transform, 0.0f, movementDistance);
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
