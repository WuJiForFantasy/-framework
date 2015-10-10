//
//  WJIPManager.m
//  getip
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJIPManager.h"
#import "IPAdress.h"
@implementation WJIPManager

+ (NSString *)getIPAdress {
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s",ip_names[1]];
}

@end
