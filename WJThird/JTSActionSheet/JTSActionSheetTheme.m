//
//  JTSActionSheetTheme.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetTheme.h"

#define JTSActionSheetDefaultActionColor [UIColor colorWithRed:0.09 green:0.50 blue:0.99 alpha:1.0]
#define JTSActionSheetDefaultDestructionColor [UIColor colorWithRed:0.99 green:0.24 blue:0.22 alpha:1.0]
#define JTSActionSheetDefaultTitleColor [UIColor colorWithWhite:0.5 alpha:1.0]
#define JTSActionSheetDefaultBackgroundColor [UIColor colorWithWhite:0.99 alpha:0.96]
#define JTSActionSheetDefaultBackdropShadowColor [UIColor colorWithWhite:0.0 alpha:0.4]
#define JTSActionSheetDefaultSeparatorColor [UIColor colorWithWhite:0.0 alpha:0.6]
#define JTSActionSheetDefaultButtonHighlightOverlayColor [UIColor colorWithWhite:0.0 alpha:0.09]

@implementation JTSActionSheetTheme

+ (instancetype)defaultTheme {
    
    JTSActionSheetTheme *theme = [[JTSActionSheetTheme alloc] init];
    
    theme.backgroundStyle = JTSActionSheetStyle_SolidColor;
    theme.separatorStyle = JTSActionSheetStyle_SolidColor;
    
    theme.titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    theme.normalButtonFont = [UIFont systemFontOfSize:19];
    theme.boldButtonFont = [UIFont boldSystemFontOfSize:19];
    
    theme.normalButtonColor = JTSActionSheetDefaultActionColor;
    theme.destructiveButtonColor = JTSActionSheetDefaultDestructionColor;
    theme.titleColor = JTSActionSheetDefaultTitleColor;
    theme.backdropShadowColor = JTSActionSheetDefaultBackdropShadowColor;
    theme.backgroundColor = JTSActionSheetDefaultBackgroundColor;
    theme.separatorColor = JTSActionSheetDefaultSeparatorColor;
    theme.buttonHighlightOverlayColor = JTSActionSheetDefaultButtonHighlightOverlayColor;
    
    return theme;
}

@end
