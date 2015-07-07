//
//  WJEasyInputTextView.h
//  键盘上的输入框
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用 直接初始化，也可以改属性
 WJEasyInputTextView *wj = [[WJEasyInputTextView alloc]init];
 wj.bgColor = [UIColor orangeColor];
 wj.showLimitNum = YES;
 wj.font = [UIFont systemFontOfSize:18];
 wj.limitNum = 13;
 [self.view addSubview:wj];
 */

@interface WJEasyInputTextView : UIView

@property (nonatomic,strong)UIColor *bgColor;   //背景色
@property (nonatomic,assign)BOOL showLimitNum; //显示字数
@property (nonatomic,assign)NSInteger limitNum; //限制字数
@property (nonatomic,strong)UIFont *font;       //文字大小

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,copy) void(^sendBlock)(void);
@property (nonatomic,assign)BOOL isNav;
@end
