//
//  WJTabBarControl.h
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTabBarControl : UITabBarController

@property (nonatomic,strong) UIColor *itemTextSelectColor;
@property (nonatomic,strong) UIColor *itemTextColor;
@property (nonatomic,strong) UIColor *tabBarBackgroundColor;

 /** 显示tabar*/
- (void)showTabBar;
 /** 隐藏tabar*/
- (void)hidTabBar;
 /** 跳到相应的控制器*/
- (void)selectControlAtIndex:(NSInteger)index;
 /** 给标签控制器添加子控制器*/
- (void)addControlOfControlNameArray:(NSArray *)array itemName:(NSArray *)itemName itemImageStringArray:(NSArray *)imageArray itemImageSelectStringArray:(NSArray *)selectImageArray;

@end
