//
//  semicircleView.h
//  molove
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 waste. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemicircleView : UIView


/**
 *  传入数值(改变圆角位置)
 *
 *  @param index 0:下,1:上,2,上下,3无
 */
- (void)upOrdownsemicirc:(NSInteger)index;

@end
