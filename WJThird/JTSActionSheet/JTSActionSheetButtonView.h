//
//  JTSActionSheetButton.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetItemView.h"

#import "JTSActionSheetItem.h"

@class JTSActionSheetButtonView;

@protocol JTSActionSheetButtonViewDelegate <NSObject>

- (void)buttonViewWasSelected:(JTSActionSheetButtonView *)view forItem:(JTSActionSheetItem *)item;

@end

@interface JTSActionSheetButtonView : JTSActionSheetItemView

@property (strong, nonatomic, readonly) JTSActionSheetItem *item;

- (instancetype)initWithItem:(JTSActionSheetItem *)item
                isCancelItem:(BOOL)isCancelItem
                    delegate:(id <JTSActionSheetButtonViewDelegate>)delegate
                       theme:(JTSActionSheetTheme *)theme
                    position:(JTSActionSheetItemViewPosition)position;

@end
