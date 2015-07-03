//
//  ViewController.m
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "WJTabBarControl.h"
@interface ViewController () {
    BOOL _bool;
    WJTabBarControl *_tabBar;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _bool = !_bool;
  
    if (_bool) {
        [self tabBarHidden];
    }else {
        [self tabBarShow];
    }
    
}

@end
