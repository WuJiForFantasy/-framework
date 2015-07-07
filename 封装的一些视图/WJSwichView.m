//
//  WJSwichView.m
//  molove
//
//  Created by apple on 15/6/16.
//  Copyright (c) 2015年 waste. All rights reserved.
//

#import "WJSwichView.h"

@interface WJSwichView () {
    NSInteger _width;
    NSInteger _height;
    UIButton *_button;//滑条
    BOOL _isChoose;
    BOOL _check;//点击按钮或者下面的（按钮为yes）
}
@property (nonatomic,strong)NSString *leftTitle;
@property (nonatomic,strong)NSString *rightTitle;
@property (nonatomic,assign)CGFloat font;
@property (nonatomic,strong)NSString *color;
@end

@implementation WJSwichView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataSource:frame];
        [self initView];
    }
    return self;
}

- (void)initDataSource:(CGRect)frame {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = frame.size.height/2;
    _width = frame.size.width;
    _height = frame.size.height;
    _font = 16;
    _leftTitle = @"动态";
    _rightTitle = @"恋爱秀";
    self.backgroundColor = [UIColor colorWithHexString:@"fb4287"];
    _check = NO;
}

- (void)initView{
    for (int i = 0; i < 2; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * _width/2, 0, _width/2, _height)];
        label.font = [UIFont systemFontOfSize:_font];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"aa003f"];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = i+10;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        if (i == 0) {
            label.text = _leftTitle;
        }else {
            label.text = _rightTitle;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressed:)];
        [label addGestureRecognizer:tap];
        
    }
    _button = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, _width/2, _height-2)];
    _button.layer.cornerRadius = _height/2;
    _button.clipsToBounds = YES;
    _button.titleLabel.font = [UIFont systemFontOfSize:14];
    _button.backgroundColor = [Common colorWithTheme];
    [_button setTitle:_leftTitle forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
}

#pragma mark - 事件监听
//点击底部
- (void)tapPressed:(UITapGestureRecognizer *)sender {
    if (!_check) {
          _isChoose = !_isChoose;
        if (sender.view.tag == 10) {
            [self leftView];
        }else {
            [self rightView];
        }
        if ([_delegate respondsToSelector:@selector(wjSwichViewDidFinsh:)]) {
            [_delegate wjSwichViewDidFinsh:_isChoose];
        }
    }
    
    
}
//点击按钮
- (void)buttonPressed:(UIButton *)sender {
    if (_check) {
        _isChoose = !_isChoose;
        if (_isChoose) {
            [self rightView];
        }else {
            [self leftView];
        }
        if ([_delegate respondsToSelector:@selector(wjSwichViewDidFinsh:)]) {
            [_delegate wjSwichViewDidFinsh:_isChoose];
        }
    }
}

#pragma mark - others

- (void)leftView {
    [UIView animateWithDuration:0.2 animations:^{
        _button.frame = CGRectMake(1, 1, _width/2, _height-2);
        [_button setTitle:_leftTitle forState:UIControlStateNormal];
    }];
   
}

- (void)rightView {
    [UIView animateWithDuration:0.2 animations:^{
        _button.frame = CGRectMake(_width/2-1, 1, _width/2, _height-2);
        [_button setTitle:_rightTitle forState:UIControlStateNormal];
    }];
}

@end
