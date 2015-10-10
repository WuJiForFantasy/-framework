//
//  NSDataFormatter+WJCategory.m
//  横向选择器
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "NSDataFormatter+WJCategory.h"

@implementation NSDateFormatter (WJCategory)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
