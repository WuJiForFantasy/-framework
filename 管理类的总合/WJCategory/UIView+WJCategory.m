//
//  UIView+WJCategory.m
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "UIView+WJCategory.h"

@implementation UIView (WJCategory)

/*截图*/
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 2.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Animation

- (void)startShakeAnimation
{
    CGFloat rotation = 0.05;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.2;
    shake.autoreverses = YES;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -rotation, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  rotation, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)stopShakeAnimation
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

- (void)startRotateAnimation
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.5;
    shake.autoreverses = NO;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, M_PI, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  0.0, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"rotateAnimation"];
}

- (void)stopRotateAnimation
{
    [self.layer removeAnimationForKey:@"rotateAnimation"];
}

@end
