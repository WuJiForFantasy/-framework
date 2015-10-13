//
//  WJNetworking.h
//  WJNetworking
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//请求成功回调
typedef void (^SuccessBlock)(NSDictionary *dataDic);
//请求失败
typedef void (^FailBlock)(NSError *failObj);

@interface WJNetworking : NSObject

/**普通get网络请求*/
+ (void)netWorkingIsGetWithURL:(NSString *)urlpath param:(NSDictionary *)dic success:(SuccessBlock)succsess fail:(FailBlock)fail;
/**普通post网络请求*/
+ (void)netWorkingIsPostWithURL:(NSString *)urlpath param:(NSDictionary *)dict success:(SuccessBlock)succsess fail:(FailBlock)fail;
@end
