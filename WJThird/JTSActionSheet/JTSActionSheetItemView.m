//
//  JTSActionSheetItemView.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetItemView.h"

#import "JTSActionSheetTheme.h"

CGFloat const JTSActionSheetItemViewCornerRadius = 4.0f;
CGFloat const JTSActionSheetItemDefaultHeight = 44.0;

@interface JTSActionSheetItemView ()

@property (strong, nonatomic, readwrite) JTSActionSheetTheme *theme;
@property (assign, nonatomic, readwrite) JTSActionSheetItemViewPosition position;
@property (strong, nonatomic) UIView *blurringView;
@property (strong, nonatomic) CAShapeLayer *roundedCornerMask;
@property (assign, nonatomic) BOOL isInitialized;

@end

@implementation JTSActionSheetItemView

#pragma mark - Public

- (instancetype)initWithTheme:(JTSActionSheetTheme *)theme position:(JTSActionSheetItemViewPosition)position {
    self = [super initWithFrame:CGRectMake(0, 0, 304, 44)];
    if (self) {
        
        _isInitialized = YES;
        _theme = theme;
        _position = position;
                
        if (theme.backgroundStyle == JTSActionSheetStyle_WhiteBlurred) {
            NSAssert(NO, @"Blurred themes not yet supported");
        }
        else if (theme.backgroundStyle == JTSActionSheetStyle_DarkBlurred) {
            NSAssert(NO, @"Blurred themes not yet supported");
        }
        else {
            self.backgroundColor = theme.backgroundColor;
        }
    }
    return self;
}

- (CGFloat)intrinsicHeightGivenAvailableWidth:(CGFloat)availableWidth {
    return JTSActionSheetItemDefaultHeight;
}

#pragma mark - UIView

- (void)setFrame:(CGRect)frame {
    
    if (self.isInitialized == NO) {
        [super setFrame:frame];
    }
    else if (self.position == JTSActionSheetItemViewPosition_Middle) {
        [super setFrame:frame];
    }
    else {
        BOOL clippingMaskIsDirty = (frame.size.width != self.bounds.size.width);
        [super setFrame:frame];
        if (clippingMaskIsDirty || self.roundedCornerMask == nil) {
            UIRectCorner corners = [self cornerClipForPosition:self.position];
            CGSize radii = CGSizeMake(JTSActionSheetItemViewCornerRadius, JTSActionSheetItemViewCornerRadius);
            if (self.roundedCornerMask == nil) {
                self.roundedCornerMask = [CAShapeLayer layer];
                self.roundedCornerMask.frame = self.bounds;
                self.layer.mask = self.roundedCornerMask;
            }
            self.roundedCornerMask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii].CGPath;
        }
    }
}

#pragma mark - Private

- (UIRectCorner)cornerClipForPosition:(JTSActionSheetItemViewPosition)position {
    
    UIRectCorner corners;
    
    switch (position) {
        case JTSActionSheetItemViewPosition_Single:
            corners = UIRectCornerAllCorners;
            break;
        case JTSActionSheetItemViewPosition_Top:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case JTSActionSheetItemViewPosition_Middle:
            corners = 0;
            NSLog(@"[%@ cornerClipForPosition:] - Warning! Do not round corners for the middle position.", NSStringFromClass([self class]));
            break;
        case JTSActionSheetItemViewPosition_Bottom:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
            
        default:
            corners = 0;
            break;
    }
    
    return corners;
}

@end
