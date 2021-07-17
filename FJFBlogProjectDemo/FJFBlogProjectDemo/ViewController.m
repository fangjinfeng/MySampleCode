//
//  ViewController.m
//  FJFBlogDemo
//
//  Created by jspeakfang on 1/1/21.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// tableView
@property (nonatomic, strong) UITableView *tableView;
// viewControllerDict
@property (nonatomic, strong) NSDictionary <NSString *, NSString *> *viewControllerDict;
@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - System Delegate

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllerDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *keyArray = [self.viewControllerDict allKeys];
    cell.textLabel.text = [self.viewControllerDict objectForKey:keyArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSArray *keyArray = [self.viewControllerDict allKeys];
    NSString *className = keyArray[indexPath.row];
    id class = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:class animated:YES];
}

#pragma mark - Setter / Getter

// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height ) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}



// viewControllerDict
- (NSDictionary <NSString *, NSString *> *)viewControllerDict {
    if (!_viewControllerDict) {
        _viewControllerDict = @{
                                @"FJFAnimationViewController": @"removeAllAnimations 引起的问题记录",
                                @"FJFLazyTableViewController": @"tableView懒加载 调用两次引发的问题",
                                @"FJFWebViewController": @"iOS关于html图片原生加载逻辑处理",
                                @"FJFUrlEncodeViewController": @"iOS关于字符串处理逻辑",
                                @"FJFFirstViewController": @"仿高德路线规划滑动效果",
                                };
    }
    return _viewControllerDict;
}
@end
