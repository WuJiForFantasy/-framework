//
//  JTSActionSheetViewController.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheetViewController.h"

#import "JTSActionSheet.h"
#import "JTSActionSheet_Protected.h"

@interface JTSActionSheetViewController ()
<
    JTSActionSheetDelegate,
    UIGestureRecognizerDelegate
>

@property (strong, nonatomic) JTSActionSheet *sheet;
@property (strong, nonatomic) UIView *backdropShadowView;
@property (assign, nonatomic) BOOL sheetIsVisible;
@property (strong, nonatomic) UITapGestureRecognizer *dismissTapRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *dismissSwipeRecognizer;

@end

@implementation JTSActionSheetViewController

#pragma mark - Public

- (id)initWithActionSheet:(JTSActionSheet *)sheet {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _sheet = sheet;
        _sheet.autoresizingMask = UIViewAutoresizingNone;
        [_sheet setDelegate:self];
    }
    return self;
}

- (void)playPresentationAnimation:(BOOL)animated tintableUnderlyingView:(UIView *)view {
    if (self.sheetIsVisible == NO) {
        self.sheetIsVisible = YES;
        UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction | 7 << 16; // unpublished default curve
        CGFloat duration = (animated) ? 0.3 : 0;
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            self.sheet.transform = CGAffineTransformIdentity;
            self.backdropShadowView.alpha = 1;
            [self.sheet addMotionEffects];
        } completion:nil];
    }
}

- (void)playDismissalAnimation:(BOOL)animated tintableUnderlyingView:(UIView *)view completion:(void(^)(void))completion {
    if (self.sheetIsVisible == YES) {
        self.sheetIsVisible = NO;
        UIViewAnimationOptions options = 6 << 16; // unpublished default curve
        CGFloat duration = (animated) ? 0.25 : 0;
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            self.sheet.transform = CGAffineTransformMakeTranslation(0, self.sheet.bounds.size.height);
            self.backdropShadowView.alpha = 0;
            [self.sheet removeMotionEffects];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.dismissTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTapRecognized:)];
    self.dismissTapRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.dismissTapRecognizer];
    
    self.dismissSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSwipeRecognized:)];
    self.dismissSwipeRecognizer.delegate = self;
    self.dismissSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.dismissSwipeRecognizer];
    
    self.backdropShadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backdropShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backdropShadowView.backgroundColor = self.sheet.theme.backdropShadowColor;
    self.backdropShadowView.alpha = 0;
    [self.view addSubview:self.backdropShadowView];
    
    [self.view addSubview:self.sheet];
    [self repositionSheet];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self repositionSheet];
}

#pragma mark - Layout

- (void)repositionSheet {
    CGFloat actionSheetWidth = self.view.bounds.size.width;
    CGFloat actionSheetHeight = ceilf([self.sheet intrinsicHeightGivenAvailableWidth:actionSheetWidth]);
    self.sheet.bounds = CGRectMake(0, 0, actionSheetWidth, actionSheetHeight);
    self.sheet.center = CGPointMake(roundf(actionSheetWidth / 2.0), roundf(self.view.bounds.size.height - actionSheetHeight / 2.0));
    if (self.sheetIsVisible) {
        self.sheet.transform = CGAffineTransformIdentity;
    } else {
        self.sheet.transform = CGAffineTransformMakeTranslation(0, actionSheetHeight);
    }
}

#pragma mark - Dismissal Recognizers

- (void)dismissTapRecognized:(UITapGestureRecognizer *)sender {
    JTSActionBlock actionBlock = self.sheet.cancelItem.actionBlock;
    [self.delegate actionSheetViewControllerDidDismiss:self completion:^{
        if (actionBlock) {
            actionBlock();
        }
    }];
}

- (void)dismissSwipeRecognized:(UISwipeGestureRecognizer *)sender {
    JTSActionBlock actionBlock = self.sheet.cancelItem.actionBlock;
    [self.delegate actionSheetViewControllerDidDismiss:self completion:^{
        if (actionBlock) {
            actionBlock();
        }
    }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (CGRectContainsPoint(self.sheet.frame, [touch locationInView:self.view]) == NO);
}

#pragma mark - JTSActionSheetDelegate

- (void)actionSheetDidFinish:(JTSActionSheet *)sheet completion:(void (^)(void))completion {
    [self.delegate actionSheetViewControllerDidDismiss:self completion:completion];
}

@end






