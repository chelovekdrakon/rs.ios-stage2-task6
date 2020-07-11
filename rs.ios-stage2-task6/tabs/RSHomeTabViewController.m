//
//  RSHomeTabViewController.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/11/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "RSHomeTabViewController.h"

@interface RSHomeTabViewController ()

@end

@implementation RSHomeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.navigationItem.title = @"RSSchool Task 6";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
