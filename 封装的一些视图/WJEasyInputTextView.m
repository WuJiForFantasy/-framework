//
//  WJEasyInputTextView.m
//  键盘上的输入框
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJEasyInputTextView.h"
#import "IQKeyboardManager.h"
@interface WJEasyInputTextView ()<UITextViewDelegate> {
    UIView *_bottomView;//评论框
    UITextView *_textView;//输入框
    UILabel *_textApl;//字数
    CGRect _rect;
}
@end

@implementation WJEasyInputTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 50);
        _rect = self.frame;
        [self initNotification];
        [self AddtextFieldComments];
        _isNav = NO;
    }
    return self;
}


#pragma mark - 初始化键盘监听

- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 初始化视图

- (void)AddtextFieldComments  {
    _bottomView = [[UIView alloc] initWithFrame:self.bounds];
    _bottomView.backgroundColor = self.bgColor;
    _bottomView.userInteractionEnabled= YES;
    [self addSubview:_bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
    [_bottomView addSubview:lineView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, CGRectGetWidth(self.bounds) - 115, 40)];
    _textView.layer.cornerRadius = 6;
    _textView.layer.borderWidth = 1;
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textView.autocorrectionType = UITextAutocorrectionTypeNo;
    _textView.layer.borderColor = lineView.backgroundColor.CGColor;
    [_bottomView addSubview:_textView];
    
    _textApl = [[UILabel alloc] init];
    _textApl.frame = CGRectMake(CGRectGetMaxX(_textView.frame)-37, 35, 30, 6);
    _textApl.textColor = [UIColor grayColor];
    _textApl.textAlignment = NSTextAlignmentRight;
    _textApl.font = [UIFont systemFontOfSize:8];
//    _textApl.text = @"140";
    [_bottomView addSubview:_textApl];
    
    UIButton *plBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    plBtn.layer.borderWidth = 1;
    plBtn.backgroundColor = [UIColor whiteColor];
    [plBtn setTitle:@"发送" forState:UIControlStateNormal];
    [plBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    plBtn.layer.cornerRadius = 6;
    plBtn.layer.borderColor = lineView.backgroundColor.CGColor;
    plBtn.frame = CGRectMake(CGRectGetMaxX(_textView.frame) + 10, CGRectGetMinY(_textView.frame), 80, CGRectGetHeight(_textView.frame));
    [plBtn addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:plBtn];
}

#pragma mark - get方法

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    _bottomView.backgroundColor = bgColor;
}

- (void)setLimitNum:(NSInteger)limitNum {
    NSLog(@"%ld",limitNum);
    _limitNum = limitNum;
    _textApl.text = [NSString stringWithFormat:@"%ld",limitNum];
}

- (void)setShowLimitNum:(BOOL)showLimitNum {
    _showLimitNum = showLimitNum;
    if (showLimitNum) {
        _textApl.hidden = NO;
    }else {
        _textApl.hidden = YES;
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _textView.font = font;
}

#pragma mark - 事件监听

- (void)pinglun
{
    if (_sendBlock) {
        _sendBlock();
        _textView.text = @"";
    }
    [self endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (_showLimitNum) {
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
                if (toBeString.length > _limitNum) {
                    textView.text = [toBeString substringToIndex:_limitNum];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > _limitNum) {
                textView.text = [toBeString substringToIndex:_limitNum];
            }
        }
        NSLog(@"%@",textView.text);
    }else {
        
    }
}


#pragma mark - 键盘监听

- (void)keyboardWillShow:(NSNotification *)notification
{
    //得到键盘高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    // - 49
 
//    NSLog(@"%@",keyboardRect.size.height);
    if (_isNav) {
        self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardRect.size.height - 50-64, CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame));
    }else {
        self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardRect.size.height - 50, CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame));
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    //-49
    self.frame = _rect;
//    [IQKeyboardManager sharedManager].enable = YES;
}

@end
