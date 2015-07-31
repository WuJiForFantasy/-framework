//
//  WJAttribute.m
//  WJAttribute
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJAttribute.h"

@implementation WJAttribute

+ (NSArray *)imageAuthentication:(NSString *)text {
    NSMutableArray *tmpArray = [NSMutableArray array];
    // 正则匹配图片信息
    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if (captureCount > 3) {
            // 图片信息储存
            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
            imageStorage.imageName = capturedStrings[1];
            imageStorage.range = capturedRanges[0];
            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
            
            [tmpArray addObject:imageStorage];
        }
    }];
    return tmpArray;
}

+ (void)textContainerAddImage:(TYTextContainer *)textContainer text:(NSString *)text {
    [textContainer addTextStorageArray:[self imageAuthentication:text]];
}

+ (int)attributeHeight:(TYTextContainer *)textContainer width:(CGFloat)width {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)[textContainer createAttributedString]);
    return [textContainer getHeightWithFramesetter:framesetter Width:width];
}

@end
