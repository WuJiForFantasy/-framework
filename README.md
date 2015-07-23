# -framework
自己写的程序的一些基本框架和第三方开源

解决键盘遮挡：IQKeyBoardManager
使用：

[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition]; //输入框自动上移
[IQKeyboardManager sharedManager].enableAutoToolbar = NO;

是否使用： （可能会与代码有冲突时使用）
[IQKeyboardManager sharedManager].enable = NO;

GCD封装，仿系统actionsheet,仿系统通知
