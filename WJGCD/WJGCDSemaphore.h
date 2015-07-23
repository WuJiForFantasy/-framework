//
//  WJGCDSemaphore.h
//  GCD
//
//  Created by tqh on 15/7/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//
/**
 *  gcd信号量
 */
#import <Foundation/Foundation.h>

@interface WJGCDSemaphore : NSObject
@property (strong, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化以及释放
- (instancetype)init;
- (instancetype)initWithValue:(long)value;

#pragma 用法
/**发送信号*/
- (BOOL)signal;
/**等待信号*/
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
