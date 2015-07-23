//
//  JTSActionSheet_Protected.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheet.h"

@protocol JTSActionSheetDelegate <NSObject>

- (void)actionSheetDidFinish:(JTSActionSheet *)sheet completion:(void(^)(void))completion;

@end

@interface JTSActionSheet ()

- (CGFloat)intrinsicHeightGivenAvailableWidth:(CGFloat)availableWidth;

- (void)setDelegate:(id <JTSActionSheetDelegate>)delegate;

- (void)addMotionEffects;

- (void)removeMotionEffects;

@end
