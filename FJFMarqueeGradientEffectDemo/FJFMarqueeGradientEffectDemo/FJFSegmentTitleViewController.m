//
//  FJFSegmentTitleViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 08/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFSegmentTitleView.h"
#import "FJFSegmentTitleViewController.h"

@interface FJFSegmentTitleViewController ()
// titleView
@property (nonatomic, strong) FJFSegmentTitleView *titleView;
@end

@implementation FJFSegmentTitleViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleView = [[FJFSegmentTitleView alloc] initWithFrame:CGRectMake(20, 100, 300, 40)];
    self.titleView.viewStyle.viewWidth = 200.0f;
    [self.titleView updateViewControls];
    [self.view addSubview:self.titleView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"变换" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
}

#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    self.titleView.viewStyle.viewWidth = 260;
    self.titleView.viewStyle.viewHeight = 40.0f;
    self.titleView.viewStyle.viewCornerRadius = 20.0f;
    self.titleView.viewStyle.indicatorViewHeight = 34.0f;
    self.titleView.viewStyle.indicatorViewCornerRadius = 17.0f;
    [self.titleView updateViewControls];
}

@end
