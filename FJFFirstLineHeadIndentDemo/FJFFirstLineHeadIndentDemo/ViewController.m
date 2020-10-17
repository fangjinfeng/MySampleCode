//
//  ViewController.m
//  FJFFirstLineHeadIndentDemo
//
//  Created by MacMini on 10/16/20.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView   *tableView;
// controllerNameArray
@property (nonatomic, strong) NSArray <NSString *>*controllerNameArray;
// controllerTitleArray
@property (nonatomic, strong) NSArray <NSString *>*controllerTitleArray;
@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}


#pragma mark - System Delegate

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllerNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.0)/256.0f green:arc4random_uniform(256)/256.0f blue:arc4random_uniform(256)/256.0f alpha:1.0f];
    }
    cell.textLabel.text = self.controllerTitleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = self.controllerNameArray[indexPath.row];
    [self.navigationController pushViewController:[[NSClassFromString(className) alloc] init] animated:YES];
}


#pragma mark - Gettter Methods
// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

// controllerNameArray
- (NSArray <NSString *> *)controllerNameArray {
    if (!_controllerNameArray) {
        _controllerNameArray = @[
                                 @"FJFFirstLineHeadIndentVC",
                                 @"FJFSolveProblemVC",
                                ];
    }
    return _controllerNameArray;
}

// controllerNameArray
- (NSArray <NSString *> *)controllerTitleArray {
    if (!_controllerTitleArray) {
        _controllerTitleArray = @[
                                 @"首行缩进问题",
                                 @"解决方法",
                                ];
    }
    return _controllerTitleArray;
}

@end
