//
//  NJImageCropperViewController.h
//  HeadPortrait
//
//  Created by Mr nie on 15/7/27.
//  Copyright (c) 2015年 Mr nie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NJImageCropperViewController;

@protocol NJImageCropperDelegate <NSObject>

- (void)imageCropper:(NJImageCropperViewController *) cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(NJImageCropperViewController *)cropperViewControlelr;

@end

@interface NJImageCropperViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) id<NJImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
