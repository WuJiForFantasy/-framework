//
//  JTSActionSheetPresenter.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetPresenter.h"

#import "JTSActionSheet.h"
#import "JTSActionSheetViewController.h"

@interface JTSActionSheetPresenter () <JTSActionSheetViewControllerDelegate>

@property (strong, nonatomic) JTSActionSheetViewController *currentViewController;

@end

@implementation JTSActionSheetPresenter

#pragma mark - Public

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static JTSActionSheetPresenter * sharedInstance;
    dispatch_once(&once, ^ { sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (void)presentSheet:(JTSActionSheet *)sheet fromView:(UIView *)view {
    
    NSAssert(self.currentViewController == nil, @"JTSActionSheet: trying to preset a second action sheet while another is visible.");
    
    UIWindow *window = view.window;
    UIViewController *rootVC = window.rootViewController;
    NSAssert(rootVC, @"JTSActionSheet must be presented from a view with a window with a root view controller.");
    
    self.currentViewController = [[JTSActionSheetViewController alloc] initWithActionSheet:sheet];
    self.currentViewController.delegate = self;
    self.currentViewController.view.frame = rootVC.view.frame;
    self.currentViewController.view.transform = rootVC.view.transform;
    [rootVC.view.superview addSubview:self.currentViewController.view];
    
    [self.currentViewController playPresentationAnimation:YES tintableUnderlyingView:rootVC.view];
}

#pragma mark - Private

- (void)actionSheetViewControllerDidDismiss:(JTSActionSheetViewController *)viewController
                                 completion:(void (^)(void))completion {

    UIWindow *window = viewController.view.window;
    UIViewController *rootVC = window.rootViewController;

    [self.currentViewController playDismissalAnimation:YES tintableUnderlyingView:rootVC.view completion:^{
        [self.currentViewController.view removeFromSuperview];
        self.currentViewController = nil;
        if (completion) {
            completion();
        }
    }];
}

@end
