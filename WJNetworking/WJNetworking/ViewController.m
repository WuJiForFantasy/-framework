//
//  ViewController.m
//  WJNetworking
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "ViewController.h"
#import "WJNetworking.h"

@interface ViewController ()
@property (nonatomic,assign)NSInteger timeoutID;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //http://192.168.0.136:8080/moai2.0/vip/buyvip.do
    //http://www.weather.com.cn/data/sk/101010100.html
//    static NSInteger timeoutID = 0;
//    timeoutID ++;
//    _timeoutID = timeoutID;
    static BOOL istimeOut = YES;
    //网络请求异步
    istimeOut = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (istimeOut) {
            NSLog(@"链接超时");
            NSLog(@"放那边的网络请求停止");
        }
    });
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //http://192.168.0.136:8080/moai2.0/vip/buyvip.do
    
    //https://api.sms.mob.com/sms/verify
    
    //@"http://www.weather.com.cn/data/sk/101010100.html"
    
    
    //http://wiki.mob.com/smssdk-web-1-3-0verify/
    
    //http://wiki.mob.com/smssdk-service-verify/
    
    NSString *urlPath = @"https://web.sms.mob.com/sms/verify";
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@"721af810eab5" forKey:@"appkey"];
    [params setObject:@"18398521006" forKey:@"phone"];
    [params setObject:@"86" forKey:@"zone"];
    [params setObject:@"4866" forKey:@"code"];
    
    [WJNetworking netWorkingIsPostWithURL:urlPath param:params success:^(NSDictionary *dataDic) {
        NSLog(@"%@",dataDic);
    } fail:^(NSError *failObj) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
