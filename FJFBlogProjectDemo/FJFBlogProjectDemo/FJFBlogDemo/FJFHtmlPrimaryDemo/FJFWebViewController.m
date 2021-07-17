//  WebView
//  Created by FJF on 11/05/2020.
//  Copyright © 2020 FJF. All rights reserved.


#import "Masonry.h"
#import "FJFWebViewController.h"
#import "FJFWebViewHeaderView.h"

@interface FJFWebViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat webHeight;
// headerView
@property (nonatomic, strong) FJFWebViewHeaderView *headerView;
@end

@implementation FJFWebViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self updateHeaderView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行数据",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preservesSuperviewLayoutMargins = NO;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


#pragma mark - Private Methods

// 更新 头部
- (void)updateHeaderView {
    self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.webHeight);
    self.tableView.tableHeaderView = self.headerView;
}


#pragma mark - Getter Methods
// headerView
- (FJFWebViewHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [FJFWebViewHeaderView new];
        [_headerView loadHtmlFileName:@"test"];
        //  计算网页高度 刷新headerView
        __weak typeof(self) weakSelf = self;
        [_headerView setWebViewHeightHandler:^(CGFloat height) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            weakSelf.webHeight = height;    //  让网页高度等于组头高度
            [strongSelf updateHeaderView];
        }];
        
        //  获取网页图片数组
        [_headerView setWebViewimageArrayHandler:^(NSArray *images) {
            NSLog(@"图片数组 = %@", images);
            
        }];
        
        //  获取点击的图片链接
        [_headerView setWebViewimageURLHandler:^(NSString *url) {
            NSLog(@"imageURL = %@", url);
            
        }];
    }
    return _headerView;
}


- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44.0f;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}


@end
