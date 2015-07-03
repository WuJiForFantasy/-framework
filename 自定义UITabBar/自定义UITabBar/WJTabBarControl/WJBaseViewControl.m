//
//  WJBaseViewControl.m
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJBaseViewControl.h"
#import "WJTabBarControl.h"
@interface WJBaseViewControl ()

@end

@implementation WJBaseViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarHidden {
    WJTabBarControl *tabBar= (WJTabBarControl *)self.tabBarController;
    [tabBar hidTabBar];
}
- (void)tabBarShow {
    WJTabBarControl *tabBar= (WJTabBarControl *)self.tabBarController;
    [tabBar showTabBar];
}

@end
