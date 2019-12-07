//
//  FJFSegmentCircleViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 07/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFSegmentCircleView.h"
#import "FJFSegmentCircleViewController.h"

@interface FJFSegmentCircleViewController ()
// segmentCircleView
@property (nonatomic, strong) FJFSegmentCircleView *segmentCircleView;
@end

@implementation FJFSegmentCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.segmentCircleView = [[FJFSegmentCircleView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    [self.view addSubview:self.segmentCircleView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"更换圆环" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
    
    
}

#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    self.segmentCircleView.segmentCircleViewStyle.startPositionType = FJFSegmentCircleViewStartPositionTypeBottom;
    
    self.segmentCircleView.segmentCircleViewStyle.strokeColorArray = @[
                                                                        [UIColor redColor],
                                                                        [UIColor blueColor],
                                                                        [UIColor greenColor],
                                                                        [UIColor yellowColor],
                                                                        [UIColor grayColor],
                                                                    ];
    
    self.segmentCircleView.segmentCircleViewStyle.strokePositionModelArray = @[
                                                                               [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.0f strokeEnd:0.2],
                                                                               [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.2f strokeEnd:0.4f],
                                                                               [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.4f strokeEnd:0.6f],
                                                                               [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.6f strokeEnd:0.7f],
                                                                               [FJFSegmentCircleViewStrokeModel configWithStrokeStart:0.7f strokeEnd:1.0],
                                                                           ];
    [self.segmentCircleView updateViewControls];
}

@end
