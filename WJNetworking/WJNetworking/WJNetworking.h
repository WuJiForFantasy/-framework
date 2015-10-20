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
/**
 * 下载文件
 *
 * @param string aUrl 请求文件地址
 * @param string aSavePath 保存地址
 * @param string aFileName 文件名
 * @param int aTag tag标识
 */
+ (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;

/** 上传图片(jpeg, png各种类型),及视频 */
+ (void)uploadFileURL:(NSString *)url parame:(NSDictionary *)parames uploadPath:(NSString *)path;



@end
