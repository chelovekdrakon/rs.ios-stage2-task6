//
//  RSHomeTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSHomeTabViewController.h"
#import "UIColor+CustomColor.h"
// animated figures
#import "RSAnimatedSquareViewController.h"
#import "RSAnimatedCircleViewController.h"
#import "RSAnimatedTriangleViewController.h"

@interface RSHomeTabViewController ()

@end

@implementation RSHomeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:containerView];
    
    [NSLayoutConstraint activateConstraints:@[
        [containerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [containerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
    
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [containerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [containerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    
    [self layoutScreenElementsOnView:containerView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.navigationItem.title = @"RSSchool Task 6";
}

#pragma mark - Layout

- (void)layoutScreenElementsOnView:(UIView *)containerView {
    UIView *topView = [self layoutTopView];
    UIView *centerView = [self layoutCenterView];
    UIView *bottomView = [self layoutBottomView];
    
    UIView *topDivider = [[UIView alloc] init];
    topDivider.translatesAutoresizingMaskIntoConstraints = NO;
    topDivider.backgroundColor = [UIColor lightGrayColor];
    
    UIView *bottomDivider = [[UIView alloc] init];
    bottomDivider.translatesAutoresizingMaskIntoConstraints = NO;
    bottomDivider.backgroundColor = [UIColor lightGrayColor];
    
    [containerView addSubview:topView];
    [containerView addSubview:centerView];
    [containerView addSubview:bottomView];
    
    [topView addSubview:topDivider];
    [bottomView addSubview:bottomDivider];
    
    CGFloat thirtPart = (1.0f/3.0f);
    
    [NSLayoutConstraint activateConstraints:@[
        [topView.topAnchor constraintEqualToAnchor:containerView.topAnchor],
        [topView.heightAnchor constraintEqualToAnchor:containerView.heightAnchor multiplier:thirtPart],
        [topView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [topView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        
        [topDivider.widthAnchor constraintEqualToAnchor:topView.widthAnchor multiplier:0.8f],
        [topDivider.heightAnchor constraintEqualToConstant:1.0f],
        [topDivider.bottomAnchor constraintEqualToAnchor:topView.bottomAnchor],
        [topDivider.centerXAnchor constraintEqualToAnchor:topView.centerXAnchor],
        
        [centerView.topAnchor constraintEqualToAnchor:topView.bottomAnchor],
        [centerView.heightAnchor constraintEqualToAnchor:containerView.heightAnchor multiplier:thirtPart],
        [centerView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [centerView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
        
        [bottomDivider.topAnchor constraintEqualToAnchor:bottomView.topAnchor],
        [bottomDivider.widthAnchor constraintEqualToAnchor:bottomView.widthAnchor multiplier:0.8f],
        [bottomDivider.heightAnchor constraintEqualToConstant:1.0f],
        [bottomDivider.centerXAnchor constraintEqualToAnchor:bottomView.centerXAnchor],
        
        [bottomView.topAnchor constraintEqualToAnchor:centerView.bottomAnchor],
        [bottomView.heightAnchor constraintEqualToAnchor:containerView.heightAnchor multiplier:thirtPart],
        [bottomView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
        [bottomView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
    ]];
}

- (UIView *)layoutTopView {
    UIDevice *device = [UIDevice currentDevice];
    
    UIView *topContentWrapper = [[UIView alloc] init];
    topContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *appleImage = [UIImage imageNamed:@"apple"];
    UIImageView *appleImageView = [[UIImageView alloc] initWithImage:appleImage];
    appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *iphoneNameLabel = [[UILabel alloc] init];
    iphoneNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    iphoneNameLabel.text = device.name;
    iphoneNameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    iphoneNameLabel.textColor = [UIColor blackColor];
    
    UILabel *iphoneLabel = [[UILabel alloc] init];
    iphoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    iphoneLabel.text = device.model;
    iphoneLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    iphoneLabel.textColor = [UIColor blackColor];
    
    UILabel *iOSVersionLabel = [[UILabel alloc] init];
    iOSVersionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    iOSVersionLabel.text = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
    iOSVersionLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    iOSVersionLabel.textColor = [UIColor blackColor];
    
    [topContentWrapper addSubview:appleImageView];
    [topContentWrapper addSubview:iphoneNameLabel];
    [topContentWrapper addSubview:iphoneLabel];
    [topContentWrapper addSubview:iOSVersionLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [iphoneLabel.leadingAnchor constraintEqualToAnchor:topContentWrapper.centerXAnchor constant:-20.0f],
        [iphoneLabel.centerYAnchor constraintEqualToAnchor:topContentWrapper.centerYAnchor],
        
        [appleImageView.centerYAnchor constraintEqualToAnchor:topContentWrapper.centerYAnchor],
        [appleImageView.trailingAnchor constraintEqualToAnchor:iphoneLabel.leadingAnchor constant:-30.0f],
        
        [iphoneNameLabel.leadingAnchor constraintEqualToAnchor:iphoneLabel.leadingAnchor],
        [iphoneNameLabel.bottomAnchor constraintEqualToAnchor:iphoneLabel.topAnchor constant:-10.0f],
        
        [iOSVersionLabel.leadingAnchor constraintEqualToAnchor:iphoneLabel.leadingAnchor],
        [iOSVersionLabel.topAnchor constraintEqualToAnchor:iphoneLabel.bottomAnchor constant:10.0f],
    ]];
    
    return topContentWrapper;
}

- (UIView *)layoutCenterView {
    UIView *centerContentWrapper = [[UIView alloc] init];
    centerContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    
    // --> Triangle
    RSAnimatedTriangleViewController *triangleVC = [[RSAnimatedTriangleViewController alloc] init];
    triangleVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [centerContentWrapper addSubview:triangleVC.view];
        
    // --> Square
    RSAnimatedSquareViewController *squareVC = [[RSAnimatedSquareViewController alloc] init];
    squareVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [centerContentWrapper addSubview:squareVC.view];

    // --> Circle
    RSAnimatedCircleViewController *circleVC = [[RSAnimatedCircleViewController alloc] init];
    circleVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [centerContentWrapper addSubview:circleVC.view];
    
    [NSLayoutConstraint activateConstraints:@[
        [squareVC.view.widthAnchor constraintEqualToConstant:squareVC.figureSize],
        [squareVC.view.heightAnchor constraintEqualToConstant:squareVC.figureSize],
        [squareVC.view.centerYAnchor constraintEqualToAnchor:centerContentWrapper.centerYAnchor],
        [squareVC.view.centerXAnchor constraintEqualToAnchor:centerContentWrapper.centerXAnchor],

        [circleVC.view.widthAnchor constraintEqualToConstant:circleVC.figureSize],
        [circleVC.view.heightAnchor constraintEqualToConstant:circleVC.figureSize],
        [circleVC.view.centerYAnchor constraintEqualToAnchor:squareVC.view.centerYAnchor],
        [circleVC.view.trailingAnchor constraintEqualToAnchor:squareVC.view.leadingAnchor constant:-33.0f],

        [triangleVC.view.widthAnchor constraintEqualToConstant:triangleVC.figureSize],
        [triangleVC.view.heightAnchor constraintEqualToConstant:triangleVC.figureSize],
        [triangleVC.view.centerYAnchor constraintEqualToAnchor:squareVC.view.centerYAnchor],
        [triangleVC.view.leadingAnchor constraintEqualToAnchor:squareVC.view.trailingAnchor constant:32.0f],
    ]];
    
    [self addChildViewController:squareVC];
    [self addChildViewController:circleVC];
    [self addChildViewController:triangleVC];
    [squareVC didMoveToParentViewController:self];
    [circleVC didMoveToParentViewController:self];
    [triangleVC didMoveToParentViewController:self];
    
    return centerContentWrapper;
}

- (UIView *)layoutBottomView {
    UIView *bottomContentWrapper = [[UIView alloc] init];
    bottomContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIButton *openGitButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 275.0f, 55.0f)];
    openGitButton.layer.cornerRadius = 27.5f;
    openGitButton.backgroundColor = [UIColor yellowColor];
    openGitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [openGitButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    [openGitButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [openGitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [openGitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [openGitButton addTarget:self action:@selector(openGitCV:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *goToStartButton = [[UIButton alloc] init];
    goToStartButton.layer.cornerRadius = 27.5f;
    goToStartButton.backgroundColor = [UIColor redColor];
    goToStartButton.translatesAutoresizingMaskIntoConstraints = NO;
    [goToStartButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    [goToStartButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [goToStartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goToStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [goToStartButton addTarget:self action:@selector(goToStart:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomContentWrapper addSubview:openGitButton];
    [bottomContentWrapper addSubview:goToStartButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [openGitButton.widthAnchor constraintEqualToConstant:275.0f],
        [openGitButton.heightAnchor constraintEqualToConstant:55.0f],
        [openGitButton.bottomAnchor constraintEqualToAnchor:bottomContentWrapper.centerYAnchor constant:-10.0f],
        [openGitButton.centerXAnchor constraintEqualToAnchor:bottomContentWrapper.centerXAnchor],
        
        [goToStartButton.widthAnchor constraintEqualToConstant:275.0f],
        [goToStartButton.heightAnchor constraintEqualToConstant:55.0f],
        [goToStartButton.topAnchor constraintEqualToAnchor:bottomContentWrapper.centerYAnchor constant:10.0f],
        [goToStartButton.centerXAnchor constraintEqualToAnchor:bottomContentWrapper.centerXAnchor],
    ]];
    
    return bottomContentWrapper;
}

#pragma mark - Actions

- (void)openGitCV:(UIButton *)button {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://chelovekdrakon.github.io/rsschool-cv/cv"] options:@{} completionHandler:nil];
}

- (void)goToStart:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
