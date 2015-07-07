//
//  semicircleView.m
//  molove
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 waste. All rights reserved.
//

#import "semicircleView.h"

@interface SemicircleView () {
    NSInteger _width;
    NSInteger _height;
    CGFloat _angle;
    UIView *_viewDetal;
}

@end

@implementation SemicircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    //[UIColor colorWithHexString:@"f3f3f3"];
    view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
//    view.backgroundColor = [UIColor redColor];
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    
    _viewDetal = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _height/2)];
    _viewDetal.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
//    _viewDetal.backgroundColor = [UIColor redColor];
    [self addSubview:view];
    [self addSubview:_viewDetal];
}

- (void)upOrdownsemicirc:(NSInteger)index {
    switch (index) {
        case 0:
            _viewDetal.frame = CGRectMake(0, 0, _width, _height/2);
            break;
        case 1:
            _viewDetal.frame = CGRectMake(0, _height/2, _width, _height/2);
            break;
        case 2:
            _viewDetal.frame = CGRectMake(0, 0, 0, 0);
            break;
        case 3:
            _viewDetal.frame = CGRectMake(0, 0, _width, _height);
            break;
        default:
            break;
    }
}

@end
