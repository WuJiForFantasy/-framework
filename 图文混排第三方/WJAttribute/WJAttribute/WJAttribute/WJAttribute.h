//
//  WJAttribute.h
//  WJAttribute
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYAttributedLabel.h"
#import "RegexKitLite.h"
#import "TYTextStorage.h"
#import "TYImageStorage.h"
@interface WJAttribute : NSObject

/*字符串中的图片验证第三方。主要用于直接字符串转换
 //类似下面那种才行
  NSString *text = @"[CYLoLi,320,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再漂泊，[haha,15,15]能用自己的力量撑起身后的家人和[haha,60,60]自己爱的人。[aa,60,60]";
 */
+ (NSArray *)imageAuthentication:(NSString *)text;
/*字符串生成图片，[CYLoLi,320,180]类似*/
+ (void)textContainerAddImage:(TYTextContainer *)textContainer text:(NSString *)text;
/*计算高度 TYTextContainer*/
+ (int)attributeHeight:(TYTextContainer *)textContainer width:(CGFloat)width;

@end
