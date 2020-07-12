//
//  UIColor+CustomColor.m
//  rs.ios-stage2-task6
//
//  Created by Фёдор Морев on 7/10/20.
//  Copyright © 2020 Фёдор Морев. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

// <0xEE686A>
+ (UIColor *)redColor {
    return [UIColor colorWithRed:238.0f/255.0f
                           green:104.0f/255.0f
                            blue:106.0f/255.0f
                           alpha:1.0f];
}

// <0x29C2D1>
+ (UIColor *)blueColor {
    return [UIColor colorWithRed:41.0f/255.0f
                           green:194.0f/255.0f
                            blue:209.0f/255.0f
                           alpha:1.0f];
}

// <0x707070>
+ (UIColor *)grayColor {
    return [UIColor colorWithRed:112.0f/255.0f
                           green:112.0f/255.0f
                            blue:112.0f/255.0f
                           alpha:1.0f];
}

// <0x979797>
+ (UIColor *)lightGrayColor {
    return [UIColor colorWithRed:151.0f/255.0f
                           green:151.0f/255.0f
                            blue:151.0f/255.0f
                           alpha:1.0f];
}

// <0x34C1A1>
+ (UIColor *)greenColor {
    return [UIColor colorWithRed:52.0f/255.0f
                           green:193.0f/255.0f
                            blue:161.0f/255.0f
                           alpha:1.0f];
}

// <0x101010>
+ (UIColor *)blackColor {
    return [UIColor colorWithRed:16.0f/255.0f
                           green:16.0f/255.0f
                            blue:16.0f/255.0f
                           alpha:1.0f];
}

// <0xF9CC78>
+ (UIColor *)yellowColor {
    return [UIColor colorWithRed:249.0f/255.0f
                           green:204.0f/255.0f
                            blue:120.0f/255.0f
                           alpha:1.0f];
}

// <0xFDF4E3>
+ (UIColor *)yellowHighlightedColor {
    return [UIColor colorWithRed:253.0f/255.0f
                           green:244.0f/255.0f
                            blue:227.0f/255.0f
                           alpha:1.0f];
}

@end
