//
//  UIImage+WJCategory.m
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "UIImage+WJCategory.h"

@implementation UIImage (WJCategory)

/*图片拉伸、平铺接口，兼容iOS5+*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 6.0) {
        return [self resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    } else if (version >= 5.0) {
        if (resizingMode == UIImageResizingModeStretch) {
            return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
        } else {//UIImageResizingModeTile
            return [self resizableImageWithCapInsets:capInsets];
        }
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

/*图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize
{
    CGFloat scaleFactor = scaledSize.width / scaledSize.height;
    CGFloat imageFactor = self.size.width / self.size.height;
    if (scaleFactor <= imageFactor) {//图片横向填充
        return CGSizeMake(scaledSize.width, scaledSize.width / imageFactor);
    } else {//纵向填充
        return CGSizeMake(scaledSize.height * imageFactor, scaledSize.height);
    }
}

/*将图片转向调整为向上*/
- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    
    UIImage *fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fixedImage;
    
}
/*以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize
{
    if (CGSizeEqualToSize(self.size, CGSizeZero) || (self.size.width <= compressedSize.width && self.size.height <= compressedSize.height)) {//不用压缩
        return self;
    }
    
    CGSize scaledSize = [self sizeOfScaleToFit:compressedSize];
    
    //压缩大小，调整转向
    UIGraphicsBeginImageContext(scaledSize);
    [self drawInRect:CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}

@end
