//
//  WJGCDQueue.h
//  GCD
//
//  Created by tqh on 15/7/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WJGCDGroup;
@interface WJGCDQueue : NSObject

@property (strong, readonly, nonatomic) dispatch_queue_t dispatchQueue;
+ (WJGCDQueue *)mainQueue;
+ (WJGCDQueue *)globalQueue;

#pragma 便利的构造方法
+ (void)executeInMainQueue:(dispatch_block_t)block;
+ (void)executeInGlobalQueue:(dispatch_block_t)block;
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;

#pragma 初始化以及释放
- (instancetype)init;
/**串行队列*/
- (instancetype)initSerial;
/**并行队列*/
- (instancetype)initConcurrent;

#pragma 用法
//异步
- (void)execute:(dispatch_block_t)block;
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta;
- (void)waitExecute:(dispatch_block_t)block;
- (void)barrierExecute:(dispatch_block_t)block;
- (void)waitBarrierExecute:(dispatch_block_t)block;
- (void)suspend;
- (void)resume;

#pragma 与GCDGroup相关
- (void)execute:(dispatch_block_t)block inGroup:(WJGCDGroup *)group;
- (void)notify:(dispatch_block_t)block inGroup:(WJGCDGroup *)group;
@end
