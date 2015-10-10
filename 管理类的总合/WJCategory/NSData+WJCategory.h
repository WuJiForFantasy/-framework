//
//  NSData+WJCategory.h
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WJCategory)

/**距离当前的时间间隔*/
- (NSString *)timeIntervalDescription;

/**精确到分钟的日期*/
- (NSString *)minuteDescription;

/**格式化日期*/
- (NSString *)formattedDateDescription;

@end
