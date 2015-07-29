//
//  WJSqliteCache.m
//  数据缓存
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJSqliteCache.h"
#define sqliteCache @"cache"

@interface WJSqliteCache () {
    WJSqliteCache *_cache;
}

@end

@implementation WJSqliteCache

- (instancetype)initSqliteCache {
    
    _cache = [[WJSqliteCache alloc]initDBWithName:@"sqliteCache.db"];
    //如果没这张表就创建
    if (![_cache isTableExists:sqliteCache]) {
        [_cache createTableWithName:sqliteCache];
    }
    return _cache;
}



@end
