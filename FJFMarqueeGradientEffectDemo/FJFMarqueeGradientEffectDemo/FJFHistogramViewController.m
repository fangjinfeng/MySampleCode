
//
//  FJFHistogramViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 09/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFHistogramContainerView.h"
#import "FJFHistogramViewController.h"

@interface FJFHistogramViewController ()
// histogramContainerView
@property (nonatomic, strong) FJFHistogramContainerView *histogramContainerView;
@end

@implementation FJFHistogramViewController
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.histogramContainerView = [[FJFHistogramContainerView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width , 300)];
    [self.view addSubview:self.histogramContainerView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"更换柱状图" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
}


#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    self.histogramContainerView.backgroundViewStyle.verticalTextArray = @[
                                                                        @"25",
                                                                        @"20",
                                                                        @"15",
                                                                        @"10",
                                                                        @"5",
                                                                        @"0",
                                                                        @"5",
                                                                        @"10",
                                                                        @"15",
                                                                        @"20",
                                                                        @"25",
                                                                        ];
    
    self.histogramContainerView.backgroundViewStyle.horizontalTextArray = @[
                                                                        @"第一节",
                                                                        @"第二节",
                                                                        @"第三节",
                                                                        @"第四节",
                                                                        @"OT",
                                                                        ];
    self.histogramContainerView.backgroundViewStyle.verticalViewSpacing = 30.0f;
    
    
    NSMutableArray *tmpFirstMarray = [NSMutableArray array];
    for (NSInteger tmpIndex = 0; tmpIndex < 4; tmpIndex++) {
       NSMutableArray *tmpSecondMarray = [NSMutableArray array];
       for (NSInteger tmpSecondIndex = 0; tmpSecondIndex < 30; tmpSecondIndex++) {
           if (tmpIndex % 2 == 0) {
               [tmpSecondMarray addObject:[NSString stringWithFormat:@"%u", arc4random() % 30]];
           } else {
                [tmpSecondMarray addObject:[NSString stringWithFormat:@"-%u", arc4random() % 40]];
           }
          
       }
       [tmpFirstMarray addObject:tmpSecondMarray];
    }
    self.histogramContainerView.histogramViewStyle.valueTextArray = tmpFirstMarray;
   
    self.histogramContainerView.histogramViewStyle.singleItemViewValue = 5;
    self.histogramContainerView.histogramViewStyle.singleItemViewHeight = 30.0f;
    [self.histogramContainerView updateViewControls];
}

@end
