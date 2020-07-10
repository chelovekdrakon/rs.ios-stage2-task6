//
//  AppDelegate.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/10/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "AppDelegate.h"
#import "RSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RSViewController *vc = [[RSViewController alloc] init];
    window.rootViewController = vc;
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
