//
//  SimpleTextViewController.m
//  TYAttributedLabelDemo
//
//  Created by SunYong on 15/4/17.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "SimpleTextViewController.h"
#import "TYAttributedLabel.h"

@interface SimpleTextViewController ()

@end

@implementation SimpleTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // addAttributedText
    TYAttributedLabel *label1 = [[TYAttributedLabel alloc]init];
    label1.text = @" 1、“0押金”租房需要完善您的全部个人资料。\n 2、“0押金”服务，目的在于减轻您的资金压力，保证 方便快捷的租房体验。\n 3、该信息将会被录入中国人民银行征信系统，请务必 保证信息真实有效。\n 4、趣易租将保证用户信息的安全。\n5、在租房过程中，发生违约、未经趣易租同意的转租 等现象，将不再获得该项服务，以及后续更丰富的优惠 服务。\n 6、只有趣易租注册用户才能享有这一服务。\n 7、对于已经交过的押金，用户在通过本次申请后，趣 易租将在3到5个工作日内将押金返还到您的账户（原 支付账户。     \n 8、最终解释权归趣易租所有。\n";
    
    // 文字间隙
    label1.characterSpacing = 2;
    // 文本行间隙
    label1.linesSpacing = 6;
    
    label1.lineBreakMode = kCTLineBreakByTruncatingTail;
    label1.numberOfLines = 0;
    // 文本字体
    label1.font = [UIFont systemFontOfSize:17];
    
    // 设置view的位置和宽，会自动计算高度
    [label1 setFrameWithOrign:CGPointMake(0, 64) Width:CGRectGetWidth(self.view.frame)];
    [self.view addSubview:label1];
    
    // appendAttributedText
    TYAttributedLabel *label2 = [[TYAttributedLabel alloc]init];
    label2.frame = CGRectMake(0, CGRectGetMaxY(label1.frame)+10, CGRectGetWidth(self.view.frame), 200);
    [self.view addSubview:label2];
    
    // 追加(添加到最后)文本
    [label2 appendText:@"\t任何值得去的地方，都没有捷径"];
    [label2 appendText:@"任何值得等待的人，都会迟来一些；\n"];
    [label2 appendText:@"\t任何值得追逐的梦想，都必须在一路艰辛中备受嘲笑。\n"];
    [label2 appendText:@"\t所以，不要怕，不要担心你所追逐的有可能是错的。\n"];
    [label2 appendText:@"\t因为，不被嘲笑的梦想不是梦想。\n"];
    label2.layer.borderWidth = 1;
    // 自适应高度
    [label2 sizeToFit];
}


@end
