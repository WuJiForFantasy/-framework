//
//  WJSqliteCache.h
//  数据缓存
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "YTKKeyValueStore.h"

@interface WJSqliteCache : YTKKeyValueStore

//创建缓存数据库
- (instancetype)initSqliteCache;

@end
