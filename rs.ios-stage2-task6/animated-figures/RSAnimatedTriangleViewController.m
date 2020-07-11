//
//  RSTriangleViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSAnimatedTriangleViewController.h"
#import "UIColor+CustomColor.h"

@interface RSAnimatedTriangleViewController ()

@end

@implementation RSAnimatedTriangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:(CGPoint){ (self.figureSize / 2), 0 }];
    [trianglePath addLineToPoint:(CGPoint){ self.figureSize, self.figureSize }];
    [trianglePath addLineToPoint:(CGPoint){ 0, self.figureSize }];
    [trianglePath closePath];

    CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
    [triangleMaskLayer setPath:trianglePath.CGPath];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.view.layer.mask = triangleMaskLayer;
}

- (void)runAnimation {
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.transform = CGAffineTransformRotate(self.view.transform, M_PI / 4);
    } completion:^(BOOL finished) {
        if (self.shouldAnimate) {
            [self runAnimation];
        }
    }];
}

@end
