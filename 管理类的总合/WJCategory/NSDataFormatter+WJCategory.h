//
//  NSDataFormatter+WJCategory.h
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDateFormatter (WJCategory)

/**初始化*/
+ (id)dateFormatter;

/**字符串为yyyy-MM-dd HH:mm:ss格式*/
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

/**返回格式为yyyy-MM-dd HH:mm:ss*/
+ (id)defaultDateFormatter;
@end
