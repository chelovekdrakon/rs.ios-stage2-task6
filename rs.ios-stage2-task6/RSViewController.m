//
//  RSViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/10/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSViewController.h"
// animated figures
#import "RSAnimatedSquareViewController.h"
#import "RSAnimatedCircleViewController.h"
#import "RSAnimatedTriangleViewController.h"
//tabs
#import "RSHomeTabViewController.h"
#import "RSInfoTabViewController.h"
#import "RSGalleryTabViewController.h"
// categories
#import "UIColor+CustomColor.h"


@interface RSViewController ()
@property (nonatomic, strong) UITabBarController *tabBarController;
@end

@implementation RSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutScreenElements];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold],
        NSForegroundColorAttributeName: [UIColor blackColor],
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    
    [self handleButtonPress:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)layoutScreenElements {
    // Triangle
    
    RSAnimatedTriangleViewController *triangleVC = [[RSAnimatedTriangleViewController alloc] init];
    [self addChildViewController:triangleVC];
    [self.view addSubview:triangleVC.view];
    [triangleVC didMoveToParentViewController:self];
    
    triangleVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [triangleVC.view.widthAnchor constraintEqualToConstant:triangleVC.figureSize],
        [triangleVC.view.heightAnchor constraintEqualToConstant:triangleVC.figureSize],
        [triangleVC.view.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor],
    ]];
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [triangleVC.view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-50.0f],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [triangleVC.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-50.0f],
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
            [circleVC.view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:50.0f],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [circleVC.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50.0f],
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
    
    
    // Button
    
    UIView *buttonWrapperView = [[UIView alloc] init];
    buttonWrapperView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:buttonWrapperView];
    
    [NSLayoutConstraint activateConstraints:@[
        [buttonWrapperView.topAnchor constraintEqualToAnchor:circleVC.view.bottomAnchor],
    ]];
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [buttonWrapperView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
            [buttonWrapperView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
            [buttonWrapperView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [buttonWrapperView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
            [buttonWrapperView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [buttonWrapperView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        ]];
    }
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor yellowColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    [button setTitle:@"START" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [buttonWrapperView addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:55.0f],
        [button.leadingAnchor constraintEqualToAnchor:buttonWrapperView.leadingAnchor constant:55.0f],
        [button.centerXAnchor constraintEqualToAnchor:buttonWrapperView.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:buttonWrapperView.centerYAnchor],
        [button.trailingAnchor constraintEqualToAnchor:buttonWrapperView.trailingAnchor constant:-55.0f],
    ]];
    
    button.layer.cornerRadius = 27.5f;
    
    [button addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Event Handlers

- (void)handleButtonPress:(UIButton *)button {
    if (self.tabBarController == nil) {
        RSInfoTabViewController *infoTabVC = [[RSInfoTabViewController alloc] init];
        infoTabVC.tabBarItem.image = [UIImage imageNamed:@"info_unselected"];
        infoTabVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        infoTabVC.tabBarItem.selectedImage = [UIImage imageNamed:@"info_selected"];
        
        RSGalleryTabViewController *galleryTabVC = [[RSGalleryTabViewController alloc] init];
        galleryTabVC.tabBarItem.image = [UIImage imageNamed:@"gallery_unselected"];
        galleryTabVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        galleryTabVC.tabBarItem.selectedImage = [UIImage imageNamed:@"gallery_selected"];
        
        RSHomeTabViewController *homeTabVC = [[RSHomeTabViewController alloc] init];
        homeTabVC.tabBarItem.image = [UIImage imageNamed:@"home_unselected"];
        homeTabVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        homeTabVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.tabBar.tintColor = [UIColor blackColor];
        tabBarController.navigationItem.hidesBackButton = YES;
        tabBarController.viewControllers = @[infoTabVC, galleryTabVC, homeTabVC];
        tabBarController.selectedIndex = 1;
        
        self.tabBarController = tabBarController;
    }
    
    [self.navigationController pushViewController:self.tabBarController animated:YES];
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
