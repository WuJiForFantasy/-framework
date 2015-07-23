//
//  JTSActionSheetPresenter.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import Foundation;
@import UIKit;

@class JTSActionSheet;

@interface JTSActionSheetPresenter : NSObject

+ (instancetype)sharedInstance;

- (void)presentSheet:(JTSActionSheet *)sheet fromView:(UIView *)view;

@end
