//
//  JTSActionSheetImageUtility.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetImageUtility.h"

@implementation JTSActionSheetImageUtility

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGSize someSize = CGSizeMake(304, 20);
    UIGraphicsBeginImageContext(someSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, someSize.width, someSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
