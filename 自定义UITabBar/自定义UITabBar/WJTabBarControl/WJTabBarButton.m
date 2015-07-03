//
//  WJTabBarButton.m
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJTabBarButton.h"

@implementation WJTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark 设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.height *0.5;
    CGFloat imageH = contentRect.size.height *0.5;
    
    return CGRectMake(contentRect.size.width/2-contentRect.size.height *0.5/2, 5, imageW, imageH);
    
}

#pragma mark 设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}

@end
