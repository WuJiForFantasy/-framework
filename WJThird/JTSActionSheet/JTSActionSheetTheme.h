//
//  JTSActionSheetTheme.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, JTSActionSheetStyle) {
    JTSActionSheetStyle_WhiteBlurred,
    JTSActionSheetStyle_DarkBlurred,
    JTSActionSheetStyle_SolidColor
};

@interface JTSActionSheetTheme : NSObject

@property (assign, nonatomic) JTSActionSheetStyle backgroundStyle;
@property (assign, nonatomic) JTSActionSheetStyle separatorStyle;

@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIFont *normalButtonFont;
@property (strong, nonatomic) UIFont *boldButtonFont;

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *normalButtonColor;
@property (strong, nonatomic) UIColor *destructiveButtonColor;

@property (assign, nonatomic) CGFloat titleBaselineOffset;
@property (assign, nonatomic) CGFloat normalButtonBaselineOffset;
@property (assign, nonatomic) CGFloat boldButtonBaselineOffset;

@property (strong, nonatomic) UIColor *backgroundColor; // Only with JTSActionSheetStyle_SolidColor backgrounds
@property (strong, nonatomic) UIColor *separatorColor; // Only with JTSActionSheetStyle_SolidColor separators
@property (strong, nonatomic) UIColor *buttonHighlightOverlayColor;
@property (strong, nonatomic) UIColor *backdropShadowColor;

+ (instancetype)defaultTheme;

@end
