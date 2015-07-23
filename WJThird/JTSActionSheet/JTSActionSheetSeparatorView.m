//
//  JTSActionSheetSeparatorView.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetSeparatorView.h"

#import "JTSActionSheetTheme.h"

@interface JTSActionSheetSeparatorView ()

@property (assign, nonatomic) JTSActionSheetStyle style;

@end

@implementation JTSActionSheetSeparatorView

- (instancetype)initWithTheme:(JTSActionSheetTheme *)theme {
    self = [super initWithFrame:CGRectMake(0, 0, 304, 0.5)];
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        _style = theme.separatorStyle;
        
        switch (_style) {
            case JTSActionSheetStyle_WhiteBlurred:
                NSAssert(NO, @"Blurred separators not yet supported");
                break;
            case JTSActionSheetStyle_DarkBlurred:
                NSAssert(NO, @"Blurred separators not yet supported");
                break;
            case JTSActionSheetStyle_SolidColor:
                self.backgroundColor = theme.separatorColor;
                break;
            default:
                break;
        }
    }
    return self;
}

@end
