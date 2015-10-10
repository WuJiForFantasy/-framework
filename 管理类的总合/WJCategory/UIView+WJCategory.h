//
//  UIView+WJCategory.h
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WJCategory)

- (void)startShakeAnimation;//摇动动画
- (void)stopShakeAnimation;
- (void)startRotateAnimation;//360°旋转动画
- (void)stopRotateAnimation;

///截图
- (UIImage *)screenshot;

@end
