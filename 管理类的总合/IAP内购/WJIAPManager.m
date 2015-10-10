//
//  WJIAPManager.m
//  ApplePayTest
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJIAPManager.h"
#import <StoreKit/StoreKit.h>

static successfulBlock _successfulBlock;
static failureBlock _failureBlock;
static cancelBlock _cancelBlock;
__strong static WJIAPManager *_manager = nil;
@interface WJIAPManager ()<SKProductsRequestDelegate,SKPaymentTransactionObserver> {
    SKPaymentTransaction *_transaction;
}
@end

@implementation WJIAPManager

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[WJIAPManager alloc]init];
        [_manager initIap];
    });
    return _manager;
}

- (void)initIap {
      [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

+ (void)startIapWithProductId:(NSString *)ProductId
                   successful:(successfulBlock)successful
                      failure:(failureBlock)failure
                       cancel:(cancelBlock)cancel {
    [WJIAPManager instance];
    _successfulBlock  = [successful copy];
    _failureBlock  = [failure copy];
    _cancelBlock  = [cancel copy];
    [_manager startIapWithProductId:ProductId];
}

- (void)startIapWithProductId:(NSString *)ProductId {
    //查询是否允许内付费
    if ([SKPaymentQueue canMakePayments]) {
        // 执行下面提到的第5步：
        [self getProductInfoWithProductId:(NSString *)ProductId];
    } else {
        NSLog(@"失败，用户禁止应用内付费购买.");
    }
}

+ (void)finish {
    [_manager finish];
}

- (void)finish {
    [[SKPaymentQueue defaultQueue] finishTransaction: _transaction];
}

// 下面的ProductId应该是事先在itunesConnect中添加好的，已存在的付费项目。否则查询会失败。
- (void)getProductInfoWithProductId:(NSString *)ProductId {
    //这里填你的产品id，根据创建的名字
    //ProductIdofvip
    //ProductId
    //com.mai.moaivip
    NSSet * set = [NSSet setWithArray:@[ProductId]];
    SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
    NSLog(@"请求开始请等待...");
}

#pragma mark - 以上查询的回调函数－－－－－－－

// 以上查询的回调函数
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    //
    NSArray *myProduct = response.products;
    NSLog(@"%@",myProduct);
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败。");
        return;
    }
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - others SKPaymentTransactionObserver


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [WJIAPManager completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                NSLog(@"交易失败");
                [WJIAPManager failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                NSLog(@"已经购买过该产品");
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}
+ (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    NSLog(@"---------进入了这里");
    NSString * productIdentifier = transaction.payment.productIdentifier;
    //transaction.transactionReceipt
    //    NSString * receipt = [[NSString alloc]initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    
    //这里要用base64编码
    //    NSLog(@"%@",receipt);
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
    }
    _successfulBlock();
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
+ (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
        _failureBlock();
    } else {
        NSLog(@"用户取消交易");
        _cancelBlock();
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



@end
