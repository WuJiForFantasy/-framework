//
//  WJTabBarControl.m
//  自定义UITabBar
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJTabBarControl.h"
#import "WJTabBarButton.h"
#import "ViewController.h"
#import <objc/runtime.h> //runtime

#define tabBarHeight 50

@interface WJTabBarControl () {
    UIImageView *_tabBarView;//自定义tabBar
    WJTabBarButton *_oldButton;//记录前一次选择de1按钮
    CGRect _rect;
}

@property (nonatomic,strong)NSArray *controlNameArray; //获得控制器的名字

@end

@implementation WJTabBarControl

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setItemTextColor:(UIColor *)itemTextColor {
    for (WJTabBarButton *item in  _tabBarView.subviews) {
        [item setTitleColor:itemTextColor forState:UIControlStateNormal];
    }
}

- (void)setItemTextSelectColor:(UIColor *)itemTextSelectColor {
    for (WJTabBarButton *item in  _tabBarView.subviews) {
        [item setTitleColor:itemTextSelectColor forState:UIControlStateSelected];
    }
}

- (void)setTabBarBackgroundColor:(UIColor *)tabBarBackgroundColor {

}

- (void)addControlOfControlNameArray:(NSArray *)array itemName:(NSArray *)itemName itemImageStringArray:(NSArray *)imageArray itemImageSelectStringArray:(NSArray *)selectImageArray {
    
    //gcd单例
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSLog(@"tip:gcd只走了一次,标签控制器添加子控制器");
        // 只执行1次的代码(这里面默认是线程安全的)
        _controlNameArray = array;
        NSMutableArray *controlArray = [[NSMutableArray alloc]init];
        //runtime方法回去控制器
        for (NSString *str in _controlNameArray) {
            //类名(对象名)
            NSString *class = str;
            const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
            Class newClass = objc_getClass(className);
            if (!newClass) {
                //创建一个类
                Class superClass = [NSObject class];
                newClass = objc_allocateClassPair(superClass, className, 0);
                //注册你创建的这个类
                objc_registerClassPair(newClass);
            }
            // 创建对象(写到这里已经可以进行随机页面跳转了)
            WJBaseViewControl *instance = [[newClass alloc] init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:instance];
            [controlArray addObject:nav];
        }
        self.viewControllers = controlArray;
        [self creatTabBarViewWithItemName:itemName itemImageStringArray:imageArray itemImageSelectStringArray:selectImageArray];
    });
   
}

#pragma mark - 创建TabBarView

- (void)creatTabBarViewWithItemName:(NSArray *)itemName itemImageStringArray:(NSArray *)imageArray itemImageSelectStringArray:(NSArray *)selectImageArray {
    self.tabBar.hidden = YES;
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - tabBarHeight, CGRectGetWidth(self.view.bounds), tabBarHeight)];
    _rect = _tabBarView.frame;
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tabBarView];
    
    //这里随便弄了一个测试
    
    if (itemName == nil) {
        [self creatButtonItem:@[@"haha",@"更多",@"xiaoxiao",@"lala"]
                   imageArray:@[@"tabbar_product",@"tabbar_more",@"tabbar_client",@"tabbar_info"] imageSelectArray:@[@"tabbar_product_selected",@"tabbar_more_selected",@"tabbar_client_selected",@"tabbar_info_selected"]];
    }else {
        [self creatButtonItem:itemName imageArray:imageArray imageSelectArray:selectImageArray];
    }
}

- (void)creatButtonItem:(NSArray *)array imageArray:(NSArray *)imageArray imageSelectArray:(NSArray *)imageSelectArray{

    CGFloat buttonW = CGRectGetWidth(self.view.bounds)/array.count;
    CGFloat buttonH = CGRectGetHeight(_tabBarView.bounds);
    
    for (int i = 0 ; i < array.count; i ++) {
        WJTabBarButton *customButton = [WJTabBarButton buttonWithType:UIButtonTypeCustom];
        customButton.tag = i;
        [customButton setTitle:array[i] forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [customButton setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [customButton setImage:[UIImage imageNamed:imageSelectArray[i]] forState:UIControlStateSelected];
        [customButton addTarget:self action:@selector(customButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        customButton.titleLabel.font = [UIFont systemFontOfSize:10];
        customButton.frame = CGRectMake(buttonW *i, 0, buttonW, buttonH);
        [_tabBarView addSubview:customButton];
        
        if(i == 0)//设置第一个选择项。（默认选择项）
        {
            _oldButton = customButton;
            _oldButton.selected = YES;
        }
    }
}

#pragma mark - 点击事件

- (void)customButtonPressed:(WJTabBarButton *)sender {
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _oldButton.selected = ! _oldButton.selected;
        _oldButton = sender;
        _oldButton.selected = YES;
    }
}

- (void)selectControlAtIndex:(NSInteger)index {
    NSInteger buttonIndex = 0;
 
    for (WJTabBarButton *button in _tabBarView.subviews) {
        if (index == buttonIndex) {
            _oldButton = button;
            button.selected = YES;
        }else {
            button.selected = NO;
        }
        buttonIndex ++;
    }
    self.selectedIndex = index;
}


#pragma mark - 弹出消失动画

- (void)showTabBar {
    [UIView animateWithDuration:0.2 animations:^{
          _tabBarView.frame = _rect;
    }];
}

- (void)hidTabBar {
    [UIView animateWithDuration:0.2 animations:^{
        _tabBarView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), tabBarHeight);
    }];
}

@end
