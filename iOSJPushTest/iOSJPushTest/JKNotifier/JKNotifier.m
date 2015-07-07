//
//  JKNotifier.m
//  JKNotifier
//
//  Created by Jakey on 15/5/21.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "JKNotifier.h"
#import <AudioToolbox/AudioToolbox.h>

@interface JKNotifier()
@property (nonatomic, strong) JKNotifierBar *notifierBar;
@property (nonatomic, strong) UIImage *defaultIcon;
@property (nonatomic, strong) NSString *appName;

@end

@implementation JKNotifier

+ (JKNotifier*)shareInstance {
    static dispatch_once_t onceToken;
    static JKNotifier *notifier;
    dispatch_once(&onceToken, ^ {
        notifier = [[self alloc] init];
    });
    return notifier;
}
#pragma --mark getter
-(NSString*)appName{
    if (!_appName) {
        _appName =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]?:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return _appName;
}
-(UIImage*)defaultIcon{
    if (!_defaultIcon) {
        
        _defaultIcon = [self loadPlistIcon] ?:[UIImage imageNamed:@"AppIcon"] ?:[UIImage imageNamed:@"AppIcon-1"] ?:[UIImage imageNamed:@"AppIcon-2"] ?:[UIImage imageNamed:@"AppIcon-3"] ?:[UIImage imageNamed:@"JKNotifier_default_icon"];
    }
    return _defaultIcon;
}
-(JKNotifierBar*)notifierBar{
    if (!_notifierBar) {
        _notifierBar = [[JKNotifierBar alloc] init];
        _notifierBar.transform = CGAffineTransformMakeTranslation(0, -_notifierBar.frame.size.height);
    }
    return _notifierBar;
}
+(void)handleClickAction:(JKNotifierBarClickBlock)notifierBarClickBlock{
   [[self shareInstance].notifierBar handleClickAction:notifierBarClickBlock];
}

#pragma --mark class method
+(JKNotifierBar*)showNotiferRemain:(NSString*)note{
    return [JKNotifier showNotiferRemain:note name:nil];
}

+(JKNotifierBar*)showNotiferRemain:(NSString*)note
                              name:(NSString*)appName{
    return [JKNotifier showNotifer:note name:appName icon:nil dismissAfter:-1];
}

+(JKNotifierBar*)showNotifer:(NSString*)note{
    return [JKNotifier showNotifer:note dismissAfter:2];
}

+(JKNotifierBar*)showNotifer:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{
    return [JKNotifier showNotifer:note name:appName icon:appIcon dismissAfter:2];
}

+ (JKNotifierBar*)showNotifer:(NSString *)note
                    dismissAfter:(NSTimeInterval)delay{
    return [self showNotifer:note name:nil icon:nil dismissAfter:delay];
}
+(JKNotifierBar*)showNotifer:(NSString*)note
                           name:(NSString*)appName
                           icon:(UIImage*)appIcon
                   dismissAfter:(NSTimeInterval)delay{
    JKNotifierBar *bar =  [[self shareInstance] showNotifer:note
                                        name:appName?:[self shareInstance].appName
                                        icon:appIcon?:[self shareInstance].defaultIcon];
    [self dismissAfter:delay];
    return bar;
}
+ (void)dismiss{
    [[self shareInstance] dismiss];
}
+ (void)dismissAfter:(NSTimeInterval)delay;
{
    if(delay<0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:[self shareInstance]  selector:@selector(dismiss) object:nil];
    }else
    {
        [[self shareInstance] performSelector:@selector(dismiss) withObject:nil afterDelay:delay];
    }

}
#pragma --instance method
-(JKNotifierBar*)showNotifer:(NSString*)note name:(NSString*)appName icon:(UIImage*)appIcon{
    
    [self.notifierBar.layer removeAllAnimations];
    self.notifierBar.userInteractionEnabled = YES;
//    int systemSoundID = 1007; //选择不同的声音范围（1000-2000）
//    AudioServicesPlaySystemSound(systemSoundID);
//    AudioServicesPlaySystemSound(1007); huizid
//    AudioServicesPlayAlertSound(1007);
    [self playSoundEffect:@"in.caf"];
    [self.notifierBar show:note name:appName icon:appIcon];
    [UIView animateWithDuration:(0.4) animations:^{
        self.notifierBar.alpha = 1.0;
        self.notifierBar.transform = CGAffineTransformIdentity;
    }];
    return self.notifierBar;
}

- (void)dismiss
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismiss) target:self argument:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.notifierBar.transform = CGAffineTransformMakeTranslation(0, -self.notifierBar.frame.size.height);
    } completion:^(BOOL finished) {
        self.notifierBar.userInteractionEnabled = NO;
    }];
}

#pragma --mark helper

-(UIImage*)loadPlistIcon{
    NSString *iconString = @"Icon.png";
    NSArray *icons = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFiles"];
    if (!icons) {
        iconString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    }
    else
    {
        iconString = icons [0];
    }
    return [UIImage imageNamed:iconString];
}

#pragma mark - 音效播放

void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

-(void)playSoundEffect:(NSString *)name{
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSLog(@"%@",audioFile);
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
    //        AudioServicesPlayAlertSound(soundID);//播放音效并震动
}

@end

