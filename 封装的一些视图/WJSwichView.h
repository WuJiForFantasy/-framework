//
//  WJSwichView.h
//  molove
//
//  Created by apple on 15/6/16.
//  Copyright (c) 2015年 waste. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSwichView.h"

@protocol WJSwichViewDelegate <NSObject>

- (void)wjSwichViewDidFinsh:(BOOL)Bool;

@end

@interface WJSwichView : UIView

@property (nonatomic,assign)id<WJSwichViewDelegate>delegate;

@end
