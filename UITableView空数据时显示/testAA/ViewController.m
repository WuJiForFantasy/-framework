//
//  ViewController.m
//  testAA
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "WJBaseTableView.h"
@interface ViewController (){
    WJBaseTableView *_tableView;
    __weak IBOutlet UIButton *button;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[WJBaseTableView alloc]initWithFrame:self.view.bounds];
    [self.view insertSubview:_tableView atIndex:0];
   
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_tableView initDataSource];
       
    }else {
     [_tableView removeDateSource];
    }
}


@end
