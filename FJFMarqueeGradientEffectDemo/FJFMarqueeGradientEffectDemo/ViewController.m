//
//  ViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by fjf on 09/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFMarqueeView.h"
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
                                @"FJFMaskViewController": @"CALayer的Mask效果演示",
                                @"FJFMarqueeViewController": @"跑马灯渐变效果",
                                @"FJFCircleViewController" : @"检测效果图",
                                @"FJFGradualCircleViewController" : @"渐变圆环",
                                @"FJFAnnulusViewController" : @"嵌套圆环",
                                @"FJFCurveGraphViewController" : @"曲线图",
                                @"FJFSegmentCircleViewController" : @"段圆环",
                                @"FJFIndicatorTriangleBorderViewController" : @"带箭头边框图",
                                @"FJFSegmentTitleViewController" : @"滚动标题",
                                @"FJFHistogramViewController" : @"柱状图",
                                };
    }
    return _viewControllerDict;
}
@end
