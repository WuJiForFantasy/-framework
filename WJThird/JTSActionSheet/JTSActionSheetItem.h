//
//  JTSActionSheetItem.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import UIKit;

typedef void(^JTSActionBlock)(void);

@interface JTSActionSheetItem : NSObject

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) JTSActionBlock actionBlock;
@property (assign, nonatomic, readonly) BOOL destructive;

+ (instancetype)itemWithTitle:(NSString *)title
                       action:(JTSActionBlock)actionBlock
                isDestructive:(BOOL)isDestructive;

@end
