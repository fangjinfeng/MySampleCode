//
//  FJFButtonClickedViewController.m
//  FJFBlogProjectDemo
//
//  Created by peakfang on 2022/5/12.
//  Copyright © 2022 方金峰. All rights reserved.
//

#import "Masonry.h"
#import "FJFTestView.h"
#import "FJFTestButton.h"
#import "FJFButtonClickedViewController.h"

@interface FJFButtonClickedViewController ()
@property (nonatomic, strong) FJFTestView *testButton;
@end

@implementation FJFButtonClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.testButton];
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)testButtonClicked:(UIButton *)sender {
    NSLog(@"--------------------");
}
#pragma mark - Getter Methods

- (FJFTestView *)testButton {
    if (!_testButton) {
        _testButton = [[FJFTestView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
        _testButton.backgroundColor = [UIColor yellowColor];
    }
    return _testButton;
}
@end
