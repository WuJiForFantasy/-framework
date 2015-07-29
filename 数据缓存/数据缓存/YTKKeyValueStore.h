//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject

/**
 *  打开数据库不存在在沙盒中创建
 *
 *  @param dbName 数据库的名字test.db
 *
 */
- (id)initDBWithName:(NSString *)dbName;
/**
 *  工程路径打开数据库
 *
 *  @param dbPath 工程路径
 *
 */
- (id)initWithDBWithPath:(NSString *)dbPath;
/**
 *  创建表
 *
 *  @param tableName 表的名字
 */
- (void)createTableWithName:(NSString *)tableName;

- (BOOL)isTableExists:(NSString *)tableName;
/**
 *  清除表
 */
- (void)clearTable:(NSString *)tableName;
/**
 *  关闭数据库
 */
- (void)close;

///************************ Put&Get methods *****************************************

//存入（NSString, NSNumber, NSDictionary和NSArray）修改和添加
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
//取出 （NSString, NSNumber, NSDictionary和NSArray）
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
//删除
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;
//更多接口
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
//获得所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;
//数量
- (NSUInteger)getCountFromTable:(NSString *)tableName;




@end
