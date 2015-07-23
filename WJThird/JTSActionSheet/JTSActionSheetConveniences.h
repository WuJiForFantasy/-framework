//
//  JTSActionSheetConveniences.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import Foundation;

#import "JTSActionSheetItem.h"

static inline JTSActionSheetItem * JTSActionSheetDefaultCancelItem(NSString *alternateCancelTitle) {
    NSString *title = nil;
    if (alternateCancelTitle) {
        title = alternateCancelTitle;
    } else {
        title = @"Cancel";
    }
    return [JTSActionSheetItem itemWithTitle:title action:nil isDestructive:NO];
}

extern CGFloat const JTSActionSheetMargin;
