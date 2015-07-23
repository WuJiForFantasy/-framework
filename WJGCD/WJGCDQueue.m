//
//  WJGCDQueue.m
//  GCD
//
//  Created by tqh on 15/7/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJGCDQueue.h"
#import "WJGCDGroup.h"
static WJGCDQueue *mainQueue;
static WJGCDQueue *globalQueue;
static WJGCDQueue *highPriorityGlobalQueue;
static WJGCDQueue *lowPriorityGlobalQueue;
static WJGCDQueue *backgroundPriorityGlobalQueue;

@interface WJGCDQueue ()
@property (strong, readwrite, nonatomic) dispatch_queue_t dispatchQueue;
@end

@implementation WJGCDQueue

+ (WJGCDQueue *)mainQueue {
    return mainQueue;
}

+ (WJGCDQueue *)globalQueue {
    return globalQueue;
}

+ (WJGCDQueue *)highPriorityGlobalQueue {
    return highPriorityGlobalQueue;
}

+ (WJGCDQueue *)lowPriorityGlobalQueue {
    return lowPriorityGlobalQueue;
}

+ (WJGCDQueue *)backgroundPriorityGlobalQueue {
    return backgroundPriorityGlobalQueue;
}

+ (void)initialize {
    if (self == [WJGCDQueue self])  {
        mainQueue = [WJGCDQueue new];
        mainQueue.dispatchQueue = \
        dispatch_get_main_queue();
        
        globalQueue = [WJGCDQueue new];
        globalQueue.dispatchQueue = \
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        highPriorityGlobalQueue = [WJGCDQueue new];
        highPriorityGlobalQueue.dispatchQueue = \
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        lowPriorityGlobalQueue = [WJGCDQueue new];
        lowPriorityGlobalQueue.dispatchQueue = \
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        
        backgroundPriorityGlobalQueue = [WJGCDQueue new];
        backgroundPriorityGlobalQueue.dispatchQueue = \
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

- (instancetype)init {
    return [self initSerial];
}
//串行
- (instancetype)initSerial {
    self = [super init];
    if (self)
    {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}
//并行
- (instancetype)initConcurrent {
    self = [super init];
    if (self)
    {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


- (void)execute:(dispatch_block_t)block {
    dispatch_async(self.dispatchQueue, block);
}

//延时操作
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta {
    // NSEC_PER_SEC
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), self.dispatchQueue, block);
}

//同步
- (void)waitExecute:(dispatch_block_t)block {
    /*
     As an optimization, this function invokes the block on
     the current thread when possible.
     
     作为一个建议,这个方法尽量在当前线程池中调用.
     */
    dispatch_sync(self.dispatchQueue, block);
}

//dispatch_barrier_async 作用是在并行队列中，等待前面两个操作并行操作完成，这里是并行输出
- (void)barrierExecute:(dispatch_block_t)block {
    /*
     The queue you specify should be a concurrent queue that you
     create yourself using the dispatch_queue_create function.
     If the queue you pass to this function is a serial queue or
     one of the global concurrent queues, this function behaves
     like the dispatch_async function.
     
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的async操作
     */
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)waitBarrierExecute:(dispatch_block_t)block {
    /*
     The queue you specify should be a concurrent queue that you
     create yourself using the dispatch_queue_create function.
     If the queue you pass to this function is a serial queue or
     one of the global concurrent queues, this function behaves
     like the dispatch_sync function.
     
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的sync操作
     
     As an optimization, this function invokes the barrier block
     on the current thread when possible.
     
     作为一个建议,这个方法尽量在当前线程池中调用.
     */
    
    dispatch_barrier_sync(self.dispatchQueue, block);
}

// dispatch_suspend会挂起dispatch queue，但并不意味着当前正在执行的任务会停下来，这只会导致不再继续执行还未执行的任务。dispatch_resume会唤醒已挂起的dispatch queue。你必须确保它们成对调用。
- (void)suspend {
    dispatch_suspend(self.dispatchQueue);
}

- (void)resume {
    dispatch_resume(self.dispatchQueue);
}

//🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳
//队列组

- (void)execute:(dispatch_block_t)block inGroup:(WJGCDGroup *)group {
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(WJGCDGroup *)group {
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}
#pragma mark - 便利的构造方法
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    [[WJGCDQueue mainQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    [[WJGCDQueue globalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    [[WJGCDQueue highPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    [[WJGCDQueue lowPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    [[WJGCDQueue backgroundPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInMainQueue:(dispatch_block_t)block {
    [[WJGCDQueue mainQueue] execute:^{
        block();
    }];
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block {
    [[WJGCDQueue globalQueue] execute:^{
        block();
    }];
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block {
    [[WJGCDQueue highPriorityGlobalQueue] execute:^{
        block();
    }];
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block {
    [[WJGCDQueue lowPriorityGlobalQueue] execute:^{
        block();
    }];
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block {
    [[WJGCDQueue backgroundPriorityGlobalQueue] execute:^{
        block();
    }];
}
@end
