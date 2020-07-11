//
//  RSViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/10/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSViewController.h"
#import "RSAnimatedSquareViewController.h"
#import "RSAnimatedCircleViewController.h"
#import "RSAnimatedTriangleViewController.h"

@interface RSViewController ()

@end

@implementation RSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutScreenElements];
}

- (void)layoutScreenElements {
    // Triangle
    
    RSAnimatedTriangleViewController *triangleVC = [[RSAnimatedTriangleViewController alloc] init];
    [self addChildViewController:triangleVC];
    [self.view addSubview:triangleVC.view];
    [triangleVC didMoveToParentViewController:self];
    
    triangleVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [triangleVC.view.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [triangleVC.view.widthAnchor constraintEqualToConstant:triangleVC.figureSize],
        [triangleVC.view.heightAnchor constraintEqualToConstant:triangleVC.figureSize],
    ]];
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [triangleVC.view.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-50.0f],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [triangleVC.view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50.0f],
        ]];
    }
    
    
    // Square
    
    RSAnimatedSquareViewController *squareVC = [[RSAnimatedSquareViewController alloc] init];
    [self addChildViewController:squareVC];
    [self.view addSubview:squareVC.view];
    [squareVC didMoveToParentViewController:self];
    
    squareVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [squareVC.view.topAnchor constraintEqualToAnchor:triangleVC.view.topAnchor],
        [squareVC.view.widthAnchor constraintEqualToConstant:squareVC.figureSize],
        [squareVC.view.heightAnchor constraintEqualToConstant:squareVC.figureSize],
        [squareVC.view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
    
    
    // Circle
    RSAnimatedCircleViewController *circleVC = [[RSAnimatedCircleViewController alloc] init];
    [self addChildViewController:circleVC];
    [self.view addSubview:circleVC.view];
    [circleVC didMoveToParentViewController:self];
    
    circleVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [circleVC.view.topAnchor constraintEqualToAnchor:squareVC.view.topAnchor],
        [circleVC.view.widthAnchor constraintEqualToConstant:circleVC.figureSize],
        [circleVC.view.heightAnchor constraintEqualToConstant:circleVC.figureSize],
    ]];
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [circleVC.view.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:50.0f],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [circleVC.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50.0f],
        ]];
    }
    

    // Title Label
    
    UIView *titleWrapperView = [[UIView alloc] init];
    titleWrapperView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:titleWrapperView];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleWrapperView.bottomAnchor constraintEqualToAnchor:circleVC.view.topAnchor],
        [titleWrapperView.centerXAnchor constraintEqualToAnchor:circleVC.view.centerXAnchor],
    ]];
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [titleWrapperView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [titleWrapperView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        ]];
    }
    
    UILabel *titleLabel = [self createTitleLabel];
    
    [titleWrapperView addSubview:titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [titleLabel.centerYAnchor constraintEqualToAnchor:titleWrapperView.centerYAnchor],
    ]];
}

#pragma mark - UI Elements Creators

- (UILabel *)createTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"Are you ready?";
    titleLabel.font = [UIFont systemFontOfSize:24.0f weight:UIFontWeightMedium];
    
    return titleLabel;
}

@end
