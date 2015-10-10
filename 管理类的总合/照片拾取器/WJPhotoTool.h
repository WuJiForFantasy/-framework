//
//  WJPhotoTool.h
//  图片拾取器
//
//  Created by apple on 15/8/5.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WJPhotoTool <NSObject>

@end

@interface WJPhotoTool : NSObject

//初始化
+ (WJPhotoTool *)sharedWJPhotoTool;

//单选截取或者选择图片，类型0拍照，1相册
- (void)WJUIImagePiker:(UIViewController *)viewControler type:(NSInteger)type needCut:(BOOL)cut block:(void(^)(UIImage *edtingImage,UIImage *originalImage)) block;

@end
