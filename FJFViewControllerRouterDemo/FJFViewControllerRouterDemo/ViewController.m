//
//  ViewController.m
//  FJFViewControllerRouterDemo
//
//  Created by 方金峰 on 2019/8/20.
//  Copyright © 2019 方金峰. All rights reserved.
//

#import "TestTableViewCell.h"
#import "ViewController.h"
#import "UIResponder+Router.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 TableView
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 ResultLabel
 */
@property (nonatomic,strong)UILabel *resultLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.resultLabel];
    [self.view bringSubviewToFront:self.resultLabel];
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];
    
    __weak typeof(self) weakSelf = self;
    self.fjf_viewControllerResponseBlock = ^(id  _Nullable blongView, id  _Nullable touchView, id  _Nullable param) {
        if ([param isKindOfClass:[NSString class]]) {
            weakSelf.resultLabel.text = param;
        }
    };
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        [_resultLabel setTextColor:[UIColor redColor]];
        [_resultLabel setBackgroundColor:[UIColor lightGrayColor]];
        [_resultLabel setFont:[UIFont systemFontOfSize:25 weight:UIFontWeightBold]];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _resultLabel;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TestTableViewCell class])];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
