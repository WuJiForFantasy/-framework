//
//  LQJPushHelper.m
//  Shangubaba
//
//  Created by 微我网络 on 15/5/15.
//  Copyright (c) 2015年 waste. All rights reserved.
//

#import "LQJPushHelper.h"
#import "APService.h"
 #define PLIST_PUSH_KEY [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"]
@implementation LQJPushHelper

+ (void)setupWithOptions:(NSDictionary *)launchOptions
{
    // 在应用启动的时候调用
    // Required
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    // ios8之后可以自定义category
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//    } else {
//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
//        // ios8之前 categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//#endif
//    }
//#else
//    // categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//#endif
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    // Required
    [APService setupWithOption:launchOptions];  
    return;
}



+ (void)registerDeviceToken:(NSData *)deviceToken
{
    // 在appdelegate注册设备处调用
    
    [APService registerDeviceToken:deviceToken];
    return;
    
    
}

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion
{
    if (completion) {
        
        completion(UIBackgroundFetchResultNewData);
    }
}

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification
{
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
    return;
}

+ (NSString *)setPushkey
{
    NSString * key = PLIST_PUSH_KEY;
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithContentsOfFile:key];
    return dic[@"APP_KEY"];
}

@end
