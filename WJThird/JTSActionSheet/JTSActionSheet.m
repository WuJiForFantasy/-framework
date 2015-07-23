//
//  JTSActionSheet.m
//  Time Zones
//
//  Created by Jared Sinclair on 7/24/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSActionSheet.h"
#import "JTSActionSheet_Protected.h"

#import "JTSActionSheetButtonView.h"
#import "JTSActionSheetTitleView.h"
#import "JTSActionSheetPresenter.h"
#import "JTSActionSheetSeparatorView.h"

@interface JTSActionSheet ()
<
    JTSActionSheetButtonViewDelegate
>

@property (strong, nonatomic, readwrite) JTSActionSheetTheme *theme;
@property (weak, nonatomic, readwrite) id <JTSActionSheetDelegate> delegate;
@property (copy, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) JTSActionSheetItem *cancelItem;
@property (strong, nonatomic) NSArray *actionItems;
@property (strong, nonatomic) JTSActionSheetTitleView *titleView;
@property (strong, nonatomic) NSArray *actionButtons;
@property (strong, nonatomic) NSArray *actionButtonSeparators;
@property (strong, nonatomic) JTSActionSheetButtonView *cancelButton;

@end

@implementation JTSActionSheet

#pragma mark - Public

- (instancetype)initWithTheme:(JTSActionSheetTheme *)theme
                        title:(NSString *)title
                  actionItems:(NSArray *)items
                   cancelItem:(JTSActionSheetItem *)cancelItem {
    
    self = [super init];
    if (self) {
        
        NSParameterAssert(theme);
        NSParameterAssert(items.count);
        NSParameterAssert(cancelItem);
        
        _theme = theme;
        
        if (title.length) {
            _title = title.copy;
            _titleView = [[JTSActionSheetTitleView alloc] initWithTitle:title
                                                                  theme:theme
                                                               position:JTSActionSheetItemViewPosition_Top];
            
            [self addSubview:_titleView];
        }
        
        _actionItems = items.reverseObjectEnumerator.allObjects;
        _actionButtons = [self actionButtonsForItems:_actionItems theme:theme titleWillBeUsed:(_title != nil)];
        
        for (JTSActionSheetButtonView *button in _actionButtons) {
            [self addSubview:button];
        }
        
        NSInteger numberOfSeparatorsRequired = _actionButtons.count - 1;
        if (title) {
            numberOfSeparatorsRequired += 1;
        }
        if (numberOfSeparatorsRequired) {
            _actionButtonSeparators = [self actionSeparators:numberOfSeparatorsRequired theme:theme];
            for (JTSActionSheetSeparatorView *separator in _actionButtonSeparators) {
                [self addSubview:separator];
            }
        }
        
        _cancelItem = cancelItem;
        _cancelButton = [[JTSActionSheetButtonView alloc]
                         initWithItem:cancelItem
                         isCancelItem:YES
                         delegate:self
                         theme:theme
                         position:JTSActionSheetItemViewPosition_Single];
        
        [self addSubview:_cancelButton];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    [[JTSActionSheetPresenter sharedInstance] presentSheet:self fromView:view];
}

#pragma mark - UIView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat cursor = self.bounds.size.height;
    CGFloat availableWidth = self.bounds.size.width;
    CGFloat buttonWidth = availableWidth - JTSActionSheetMargin * 2.0;
    CGFloat buttonHeight = [self.cancelButton intrinsicHeightGivenAvailableWidth:buttonWidth];
    CGRect buttonBounds = CGRectMake(JTSActionSheetMargin, 0, buttonWidth, buttonHeight);
    
    // CANCEL BUTTON
    CGRect cancelFrame = buttonBounds;
    cancelFrame.origin.x = JTSActionSheetMargin;
    cancelFrame.origin.y = cursor - JTSActionSheetMargin - buttonBounds.size.height;
    self.cancelButton.frame = cancelFrame;
    
    // GAP BETWEEN CANCEL BUTTON AND ACTION BUTTONS
    cursor = cancelFrame.origin.y - JTSActionSheetMargin;
    
    // GAP BETWEEN EACH ACTION BUTTON
    CGFloat gap = 1.0f / [UIScreen mainScreen].scale;
    
    CGFloat topOfBottomMostButton = cursor - buttonHeight;
    
    // FRAME FOR EACH ACTION BUTTON
    for (NSInteger index = 0; index < self.actionButtons.count; index++) {
        
        cursor -= buttonHeight;
        
        JTSActionSheetButtonView *button = self.actionButtons[index];
        
        CGRect buttonFrame = buttonBounds;
        buttonFrame.origin.y = cursor;
        button.frame = buttonFrame;
        
        if (self.actionButtons.lastObject != button) {
            cursor -= gap;
        }
    }
    
    // FRAME FOR EACH SEPARATOR
    if (self.actionButtonSeparators.count) {
        cursor = topOfBottomMostButton;
        for (NSInteger index = 0; index < self.actionButtonSeparators.count; index++) {
            cursor -= gap;
            JTSActionSheetSeparatorView *view = self.actionButtonSeparators[index];
            CGRect separatorFrame = CGRectMake(JTSActionSheetMargin, cursor, availableWidth - JTSActionSheetMargin * 2.0, gap);
            view.frame = separatorFrame;
            if (index != self.actionButtonSeparators.count-1) {
                cursor -= buttonHeight;
            }
        }
    }
    
    // TITLE VIEW
    if (self.titleView) {
        CGRect titleViewRect = CGRectZero;
        titleViewRect.size.width = buttonWidth;
        titleViewRect.size.height = [self.titleView intrinsicHeightGivenAvailableWidth:buttonWidth];
        titleViewRect.origin.x = buttonBounds.origin.x;
        titleViewRect.origin.y = cursor - titleViewRect.size.height;
        self.titleView.frame = titleViewRect;
    }
}

#pragma mark - Motion Effects

- (void)addMotionEffects {
    if (self.motionEffects.count == 0) {
        UIInterpolatingMotionEffect *verticalEffect;
        verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalEffect.minimumRelativeValue = @(-JTSActionSheetMargin);
        verticalEffect.maximumRelativeValue = @(JTSActionSheetMargin);
        
        UIInterpolatingMotionEffect *horizontalEffect;
        horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalEffect.minimumRelativeValue = @(-JTSActionSheetMargin);
        horizontalEffect.maximumRelativeValue = @(JTSActionSheetMargin);
        
        UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
        [effectGroup setMotionEffects:@[horizontalEffect, verticalEffect]];
        [self addMotionEffect:effectGroup];
    }
}

- (void)removeMotionEffects {
    for (UIMotionEffect *effect in self.motionEffects) {
        [self removeMotionEffect:effect];
    }
}

#pragma mark - Protected

- (CGFloat)intrinsicHeightGivenAvailableWidth:(CGFloat)availableWidth {
    
    CGFloat totalHeight = 0;
    
    CGFloat buttonWidth = availableWidth - JTSActionSheetMargin * 2.0;
    CGFloat buttonHeight = [self.cancelButton intrinsicHeightGivenAvailableWidth:buttonWidth];
    CGRect buttonBounds = CGRectMake(JTSActionSheetMargin, 0, buttonWidth, buttonHeight);
    
    CGFloat gap = 1.0f / [UIScreen mainScreen].scale;

    // bottom gap plus cancel button
    totalHeight += JTSActionSheetMargin + buttonBounds.size.height;
    
    // gap between cancel button and action buttons
    totalHeight += JTSActionSheetMargin;
    
    // action buttons
    totalHeight += buttonBounds.size.height * self.actionButtons.count + gap * self.actionButtons.count-1;
    
    // title view
    if (self.titleView) {
        totalHeight += gap;
        CGRect titleViewRect = CGRectZero;
        titleViewRect.size.width = buttonWidth;
        titleViewRect.size.height = [self.titleView intrinsicHeightGivenAvailableWidth:buttonWidth];
        totalHeight += titleViewRect.size.height;
    }
    
    return totalHeight;
}

- (void)setDelegate:(id <JTSActionSheetDelegate>)delegate {
    _delegate = delegate;
}

#pragma mark - Private

- (NSArray *)actionButtonsForItems:(NSArray *)items theme:(JTSActionSheetTheme *)theme titleWillBeUsed:(BOOL)titleWillBeUsed {
    
    NSAssert(items.count, @"JTSActionSheet requires at least one action item.");
    
    NSMutableArray *buttons = [NSMutableArray array];
    NSInteger ajdustedButtonCountForCornerLogic = (titleWillBeUsed) ? items.count + 1 : items.count;
    
    for (NSInteger index = 0; index < items.count; index++) {
        JTSActionSheetItemViewPosition position = [self positionForIndex:index totalCount:ajdustedButtonCountForCornerLogic];
        JTSActionSheetItem *item = items[index];
        JTSActionSheetButtonView *newButton = [[JTSActionSheetButtonView alloc]
                                               initWithItem:item
                                               isCancelItem:NO
                                               delegate:self
                                               theme:theme
                                               position:position];
        [buttons addObject:newButton];
    }
    
    return buttons;
}

- (JTSActionSheetItemViewPosition)positionForIndex:(NSInteger)index totalCount:(NSInteger)totalCount {
    
    JTSActionSheetItemViewPosition position;
    
    if (totalCount == 1) {
        position = JTSActionSheetItemViewPosition_Single;
    }
    else {
        if (index == 0) {
            position = JTSActionSheetItemViewPosition_Bottom;
        }
        else if (index == totalCount-1) {
            position = JTSActionSheetItemViewPosition_Top;
        }
        else {
            position = JTSActionSheetItemViewPosition_Middle;
        }
    }
    
    return position;
}

- (NSArray *)actionSeparators:(NSInteger)numberNeeded theme:(JTSActionSheetTheme *)theme {
    
    NSMutableArray *separators = [NSMutableArray array];
    
    for (NSInteger index = 0; index < numberNeeded; index++) {
        UIView *separator = [[JTSActionSheetSeparatorView alloc] initWithTheme:theme];
        separator.autoresizingMask = UIViewAutoresizingNone;
        [separators addObject:separator];
    }
    
    return separators;
}

#pragma mark - Button View Delegate

- (void)buttonViewWasSelected:(JTSActionSheetButtonView *)view forItem:(JTSActionSheetItem *)item {
    [self.delegate actionSheetDidFinish:self completion:^{
        if (item.actionBlock) {
            item.actionBlock();
        }

    }];
}

@end






