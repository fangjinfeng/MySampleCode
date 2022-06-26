//
//  FJFTableViewCellController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/4/21.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "FJFTableViewCell.h"
#import "FJFAvailableMemoryVc.h"
#import "FJFTableViewCellController.h"

@interface FJFTableViewCellController ()<UITableViewDelegate,UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView *tableView;
// viewCell
@property (nonatomic, strong) FJFTableViewCell *viewCell;
// tmpMutableArray
@property (nonatomic, strong) NSMutableArray *tmpMutableArray;
@end

@implementation FJFTableViewCellController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    
}
#pragma mark - System Delegate

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        FJFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FJFTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FJFAvailableMemoryVc *tmpVc = [[FJFAvailableMemoryVc alloc] init];
    [self.navigationController pushViewController:tmpVc animated:YES];
}

// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height ) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[FJFTableViewCell class] forCellReuseIdentifier:@"FJFTableViewCell"];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
@end
