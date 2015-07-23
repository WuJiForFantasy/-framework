//
//  WJGCDTimer.h
//  GCD
//
//  Created by tqh on 15/7/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJGCDQueue.h"
@interface WJGCDTimer : NSObject
@property (strong, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化以及释放
- (instancetype)init;
- (instancetype)initInQueue:(WJGCDQueue *)queue;

#pragma 用法
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
/**开始*/
- (void)start;
/**销毁*/
- (void)destroy;
@end
