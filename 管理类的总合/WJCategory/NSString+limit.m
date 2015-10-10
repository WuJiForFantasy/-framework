//
//  NSString+limit.m
//  NSString
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "NSString+limit.h"

@implementation NSString (limit)

- (NSString *)limitInTextFieldLength:(UITextField *)textField length:(NSInteger)length {
    NSString *toBeString = textField.text;
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    
    //下面的方法是iOS7被废弃的，注释
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textField.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textField.text = [toBeString substringToIndex:length];
        }
    }
    return textField.text;
}

- (NSString *)limitInTextViewLength:(UITextView *)textView length:(NSInteger)length {
    NSString *toBeString = textView.text;
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    
    //下面的方法是iOS7被废弃的，注释
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > length) {
                textView.text = [toBeString substringToIndex:length];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > length) {
            textView.text = [toBeString substringToIndex:length];
        }
    }
    return textView.text;
}

- (BOOL)limitTextPointISTwo:(NSString *)string range:(NSRange)range{
    BOOL _isHaveDian = NO;
    if ([string rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian=NO;
    }
    
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([string length]==0){
                if(single == '.'){
                    //                        [self alertView:@"亲，第一个数字不能为小数点"];
                    [string stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian=YES;
                    return YES;
                }else
                {
                    //                        [self alertView:@"亲，您已经输入过小数点了"];
                    [string stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (_isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[string rangeOfString:@"."];
                    int tt=(int)range.location - (int)ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        //                            [self alertView:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            //                [self alertView:@"亲，您输入的格式不正确"];
            [string stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return NO;
}



@end
