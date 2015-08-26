//
//  ViewController.m
//  LSPaomaView
//
//  Created by Sen on 15/8/1.
//  Copyright (c) 2015年 Sen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* text = @"两块钱,哈哈哈哈哈哈啊都回家啊几乎肯定将可获得撒快点回家的时刻会觉得好恐惧啊谁看哈的狂欢节大事";
    
    LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(40, 0, CGRectGetWidth(self.view.bounds)-80, 44) title:text];
//    [self.view addSubview:paomav];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = paomav;
//    [self.navigationController.navigationBar addSubview:paomav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
