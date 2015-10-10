//
//  UIImage+WJCategory.h
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WJCategory)

/**图片拉伸、平铺接口*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

/**图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

/**将图片转向调整为向上*/
- (UIImage *)fixOrientation;

/**以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;

@end
