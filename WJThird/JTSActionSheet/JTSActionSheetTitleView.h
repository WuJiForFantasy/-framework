//
//  JTSActionSheetTitleView.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetItemView.h"

@interface JTSActionSheetTitleView : JTSActionSheetItemView

- (instancetype)initWithTitle:(NSString *)title
                        theme:(JTSActionSheetTheme *)theme
                     position:(JTSActionSheetItemViewPosition)position;

@end
