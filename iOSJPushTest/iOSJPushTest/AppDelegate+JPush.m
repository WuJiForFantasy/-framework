//
//  AppDelegate+JPush.m
//  iOSJPushTest
//
//  Created by apple on 15/7/7.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "LQJPushHelper.h"
#import "APService.h"
#import "JKNotifier.h"

@implementation AppDelegate (JPush)
static NSString *JIGUANG_PUSH_KEY = @"bbdaffda3e8e42a481467073";

- (void)initJpush:(NSDictionary *)launchOptions {
    [LQJPushHelper setupWithOptions:launchOptions];
}

#pragma mark - 激光推送

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [LQJPushHelper registerDeviceToken:deviceToken];
    if ([APService registrationID]) {
        
        [self resetAliasAndTag];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [LQJPushHelper handleRemoteNotification:userInfo completion:nil];
    
    //收到信息
    return;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [LQJPushHelper handleRemoteNotification:userInfo completion:completionHandler];
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        //音效播放在里面
        [JKNotifier showNotifer:userInfo[@"aps"][@"alert"]];
    }
    return;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [LQJPushHelper showLocalNotificationAtFront:notification];
    return;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
    
}

#pragma mark - 在这里设置别名，标签（程序开始的时候执行一次），后面从数据库获取就行了
- (void)resetAliasAndTag
{
    //   __autoreleasing NSMutableSet * tags = [NSMutableSet set];
    //
    //   [tags addObject:[User_member instance].pushkey];
    // 设置别名
    
    [APService setTags:nil alias:JIGUANG_PUSH_KEY callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias
{
    NSLog(@"alias    %@      %d",alias,iResCode);
    
    switch (iResCode) {
        case 6002:
            [self resetAliasAndTag];
            break;
        default:;
    }
}
@end
