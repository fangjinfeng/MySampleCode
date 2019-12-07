//
//  FJFCurveGraphViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 07/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFCurveGraphContainerView.h"
#import "FJFCurveGraphViewController.h"

@interface FJFCurveGraphViewController ()
// curveGraphView
@property (nonatomic, strong) FJFCurveGraphContainerView *curveGraphView;
@end

@implementation FJFCurveGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.curveGraphView = [[FJFCurveGraphContainerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:self.curveGraphView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"更换曲线图" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
}


#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    self.curveGraphView.backgroundView.viewStyle.verticalTextArray = @[
                                                                        @"0",
                                                                        @"200",
                                                                        @"400",
                                                                        @"600",
                                                                        @"800",
                                                                        @"1000",
                                                                        @"1200",
                                                                        @"1400",
                                                                        @"1600",
                                                                        ];
    
    self.curveGraphView.backgroundView.viewStyle.horizontalTextArray = @[
                                                                        @"0",
                                                                        @"1",
                                                                        @"2",
                                                                        @"3",
                                                                        @"4",
                                                                        @"5",
                                                                        @"6",
                                                                        @"7",
                                                                        @"8",
                                                                        ];
    self.curveGraphView.backgroundView.viewStyle.verticalViewSpacing = 30.0f;
    
    
    self.curveGraphView.curveGraphView.viewStyle.valueTextArray =  @[
                                                                       @"100",
                                                                       @"550",
                                                                       @"790",
                                                                       @"680",
                                                                       @"850",
                                                                       @"180",
                                                                       @"700",
                                                                       @"760",
                                                                       @"1500",
                                                                       ];
    self.curveGraphView.curveGraphView.viewStyle.singleItemViewValue = 200;
    self.curveGraphView.curveGraphView.viewStyle.singleItemViewHeight = 30.0f;
    [self.curveGraphView updateViewControls];
}

@end
