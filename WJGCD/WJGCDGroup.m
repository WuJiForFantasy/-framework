//
//  WJGCDGroup.m
//  GCD
//
//  Created by tqh on 15/7/23.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJGCDGroup.h"

@interface WJGCDGroup ()
@property (strong, nonatomic, readwrite) dispatch_group_t dispatchGroup;
@end

@implementation WJGCDGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_group_wait(self.dispatchGroup, \
                               dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}


@end
