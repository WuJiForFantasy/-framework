//
//  NSString+limit.h
//  NSString
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (limit)
/* 限制TextFeild的长度*/
- (NSString *)limitInTextFieldLength:(UITextField *)textField length:(NSInteger)length;
/* 限制UITextView的长度*/
- (NSString *)limitInTextViewLength:(UITextView *)textView length:(NSInteger)length;
/* 限制小数点后两位*/
- (BOOL)limitTextPointISTwo:(NSString *)string range:(NSRange)range;
@end
