//
//  ViewController.h
//  test
//
//  Created by 张鹏 on 14-4-30.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CycleScrollViewDelegate <NSObject>

- (void)updateui;

/**
 *  删除
 *
 *  @param array 返回改变后的数组
 */
@optional
- (void)cycleScrollViewDeletItem:(NSArray *)array;


- (void)cycleScrollViewDidFinishCurrentPageIndex:(NSInteger)index;

@end

@interface CycleScrollViewController : UIViewController

@property (nonatomic,assign)BOOL hideDelete;
@property (nonatomic,assign)id<CycleScrollViewDelegate>delegate;

/**
 *  初始化(从本地初始化就是自己)
 *
 *  @param mixId  数组（名字或者image）
 *  @param index  下标
 *  @param myself 是不是自己（如果是自己久传入image不是的话就传入网络地址string）
 *
 *  @return 
 */

- (instancetype)initWithMixids:(NSArray *)mixId currentIndex:(int)index myself:(BOOL)myself;

@end
