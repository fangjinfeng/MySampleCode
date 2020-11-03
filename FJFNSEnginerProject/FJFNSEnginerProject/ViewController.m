//
//  ViewController.m
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import "Masonry.h"
#import "ViewController.h"
#import "FJFSuspensionManager.h"

@interface ViewController ()
// testView
@property (nonatomic, strong) UIView *testView;
// containerView
@property (nonatomic, strong) UIView *containerView;
// suspensionButton
@property (nonatomic, strong) UIButton *suspensionButton;
// layoutButton
@property (nonatomic, strong) UIButton *layoutButton;
// systemLayoutButton
@property (nonatomic, strong) UIButton *systemLayoutButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"测试1";
    
    
    // layoutButton
    self.layoutButton = [[UIButton alloc] init];
    self.layoutButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.layoutButton setTitle:@"layoutIfNeeded" forState:UIControlStateNormal];
    [self.layoutButton addTarget:self action:@selector(layoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.layoutButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.layoutButton];
    [self.layoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view).mas_offset(-100);
    }];
    
    // systemLayoutButton
    self.systemLayoutButton = [[UIButton alloc] init];
    self.systemLayoutButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.systemLayoutButton setTitle:@"systemLayoutSizeFit" forState:UIControlStateNormal];
    [self.systemLayoutButton addTarget:self action:@selector(systemLayoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.systemLayoutButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.systemLayoutButton];
    [self.systemLayoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.layoutButton.mas_top).mas_offset(-20);
    }];
    
    // suspensionButton
    self.suspensionButton = [[UIButton alloc] init];
    self.suspensionButton.backgroundColor = [UIColor blackColor];
    self.suspensionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.suspensionButton addTarget:self action:@selector(suspensionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.suspensionButton setTitle:@"suspensionView" forState:UIControlStateNormal];
    [self.view addSubview:self.suspensionButton];
    [self.suspensionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.systemLayoutButton.mas_top).mas_offset(-20);
    }];
  
    
    [self.view addSubview:self.containerView];
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor redColor];

    self.testView = [[UIView alloc] init];
    self.testView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:self.testView];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Response Event
- (void)layoutButtonClicked:(UIButton *)sender {
    [self.testView layoutIfNeeded];
}

- (void)systemLayoutButtonClicked:(UIButton *)sender {
    [self.testView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (void)suspensionButtonClicked:(UIButton *)sender {
    [[FJFSuspensionManager sharedManager] showSuspensionView];
}



@end
