//
//  WJBaseTableView.m
//  testAA
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 tqh. All rights reserved.
//

#import "WJBaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface WJBaseTableView ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITableViewDataSource,UITableViewDelegate> {

}

@property (nonatomic,strong)NSMutableArray *dataSourceArray;

@end

@implementation WJBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [UIView new];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    }
    return self;
}

- (NSMutableArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}

- (void)initDataSource {
    _dataSourceArray = [[NSMutableArray alloc]initWithArray:@[@1,@2,@3]];
    [self reloadData];
}

- (void)removeDateSource {
    [_dataSourceArray removeAllObjects];
    [self reloadData];
}

#pragma mark - UITableViewDataSource,UITabBarDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = @"123";
    return cell;
}

#pragma mark - DZNEmptyDataSetDelegate,DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"ic_defuat_image_message2"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"没有更多消息了";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//图片和文字距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, 0);
}


@end
