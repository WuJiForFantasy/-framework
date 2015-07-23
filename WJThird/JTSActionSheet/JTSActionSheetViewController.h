//
//  JTSActionSheetViewController.h
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

@import UIKit;

@class JTSActionSheet, JTSActionSheetViewController;

@protocol JTSActionSheetViewControllerDelegate <NSObject>

- (void)actionSheetViewControllerDidDismiss:(JTSActionSheetViewController *)viewController
                                 completion:(void (^)(void))completion;

@end

@interface JTSActionSheetViewController : UIViewController

@property (weak, nonatomic) id <JTSActionSheetViewControllerDelegate> delegate;

- (instancetype)initWithActionSheet:(JTSActionSheet *)sheet;

- (void)playPresentationAnimation:(BOOL)animated
           tintableUnderlyingView:(UIView *)view;

- (void)playDismissalAnimation:(BOOL)animated
        tintableUnderlyingView:(UIView *)view
                    completion:(void(^)(void))completion;

@end
