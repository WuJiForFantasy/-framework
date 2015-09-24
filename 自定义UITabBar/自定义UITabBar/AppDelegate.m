//
//  AppDelegate.m
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "AppDelegate.h"
#import "WJTabBarControl.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBarStyle];
    WJTabBarControl *tabBar = [[WJTabBarControl alloc]init];
    [tabBar addControlOfControlNameArray:@[@"ViewController",
                                           @"ViewController",
                                           @"ViewController",
                                           @"ViewController"]
                                itemName:@[@"haha",@"更多",@"xiaoxiao",@"lala"]
                    itemImageStringArray:@[@"tabbar_product",
                                           @"tabbar_more",
                                           @"tabbar_client",
                                           @"tabbar_info"]
              itemImageSelectStringArray:@[@"tabbar_product_selected",
                                           @"tabbar_more_selected",
                                           @"tabbar_client_selected",
                                           @"tabbar_info_selected"]];
    [tabBar selectControlAtIndex:2];
    _window.rootViewController = tabBar;
    [_window makeKeyAndVisible];
    return YES;
}

- (void)setupNavigationBarStyle {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        // 设置导航条背景颜色，在iOS7才这么用
        [appearance setBarTintColor:[UIColor colorWithRed:0.291 green:0.607 blue:1.000 alpha:1.000]];
        // 设置导航条的返回按钮或者系统按钮的文字颜色，在iOS7才这么用
        [appearance setTintColor:[UIColor whiteColor]];
        // 设置导航条的title文字颜色，在iOS7才这么用
        [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
        
    } else {
        // 设置导航条的背景颜色，在iOS7以下才这么用
        [appearance setTintColor:[UIColor colorWithRed:0.291 green:0.607 blue:1.000 alpha:1.000]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
