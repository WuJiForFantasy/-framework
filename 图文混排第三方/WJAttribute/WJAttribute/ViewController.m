//
//  ViewController.m
//  WJAttribute
//
//  Created by apple on 15/7/31.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "WJAttribute.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initView];
}

- (void)initView {
    NSString *text = @"[CYLoLi,100,40]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再漂泊，[haha,15,15]能用自己的力量撑起身后的家人和[haha,60,60]自己爱的人。[aa,60,60]";
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.text = text;
    [WJAttribute textContainerAddImage:textContainer text:text];
    TYAttributedLabel *label1 = [[TYAttributedLabel alloc]init];
    label1.attributedText = [textContainer createAttributedString];
    //提前生成大小
    int height = [WJAttribute attributeHeight:textContainer width:300];
    label1.frame = CGRectMake(100, 50, 300, height);
    [self.view addSubview:label1];
}

@end
