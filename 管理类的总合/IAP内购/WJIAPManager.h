//
//  WJIAPManager.h
//  ApplePayTest
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^successfulBlock)();
typedef void (^failureBlock)();
typedef void (^cancelBlock)();
@interface WJIAPManager : NSObject

//初始化的时候用
//+ (instancetype)instance;

//调用的时候用
+ (void)startIapWithProductId:(NSString *)ProductId
                   successful:(successfulBlock)successful
                      failure:(failureBlock)failure
                       cancel:(cancelBlock)cancel ;

@end
