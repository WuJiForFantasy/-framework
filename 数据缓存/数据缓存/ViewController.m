//
//  ViewController.m
//  数据缓存
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "YTKKeyValueStore.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YTKKeyValueStore *db = [[YTKKeyValueStore alloc]initDBWithName:@"hah.db"];
    [db createTableWithName:@"name"];
    [db putString:@"123" withId:@"1" intoTable:@"name"];
    [db putString:@"122133" withId:@"1" intoTable:@"name"];
    NSString *str = [db getStringById:@"1" fromTable:@"name"];
    NSLog(@"-----%@",str);
    YTKKeyValueStore *db1 = [[YTKKeyValueStore alloc]initDBWithName:@"hah.db"];
    NSString *str1 = [db1 getStringById:@"1" fromTable:@"name"];
    NSLog(@"-----%@",str1);
}

@end
