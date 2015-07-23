# 仿系统的UIActionSheet
# 使用方法：
JTSActionSheetTheme * theme = [JTSActionSheetTheme defaultTheme];
theme.titleColor = [UIColor colorWithHexString:@"33ccbf"];
theme.destructiveButtonColor = [UIColor colorWithHexString:@"33ccbf"];
theme.normalButtonColor =[UIColor colorWithHexString:@"33ccbf"];
JTSActionSheetItem * buyall = [JTSActionSheetItem itemWithTitle:@"拍照" action:^{

//判断拍照
[_wwPhonts UIimagePicker:self cramra:1 needcut:NO block:^(UIImage *editedImage, UIImage *originalImage) {
[_headBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
}];

} isDestructive:NO];
JTSActionSheetItem * deletall = [JTSActionSheetItem itemWithTitle:@"从相册中选择" action:^{
//判断从相册
[_wwPhonts UIimagePicker:self cramra:0 needcut:NO block:^(UIImage *editedImage, UIImage *originalImage) {

[_headBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
}];

} isDestructive:NO];

JTSActionSheetItem * cancel = [JTSActionSheetItem itemWithTitle:@"取消" action:^{

} isDestructive:NO];

JTSActionSheet * sheet = [[JTSActionSheet alloc]initWithTheme:theme title:nil actionItems:@[buyall,deletall] cancelItem:cancel];
[sheet showInView:self.view];
