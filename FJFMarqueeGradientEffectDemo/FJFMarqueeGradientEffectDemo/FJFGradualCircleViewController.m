
//
//  FJFGradualCircleViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 23/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFGradualCircleShapeView.h"
#import "FJFGradualCircleViewController.h"

@interface FJFGradualCircleViewController ()
// gradualCircleShapeView
@property (nonatomic, strong) FJFGradualCircleShapeView *gradualCircleShapeView;
@end

#define FJF_HEXColor(rgbValue) \
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@implementation FJFGradualCircleViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];

    FJFGradualCircleShapeViewStyle *tmpStyle = [[FJFGradualCircleShapeViewStyle alloc] init];
    tmpStyle.gradientColorArray = @[
                                    FJF_HEXColor(0xFFA400),
                                    FJF_HEXColor(0xFF9000),
                                    FJF_HEXColor(0xFF8100),
                                    FJF_HEXColor(0xFF6B00),
                                    FJF_HEXColor(0xFF5A00),
                                    ];
    
    self.gradualCircleShapeView = [[FJFGradualCircleShapeView alloc] initWithFrame:CGRectMake(150, 200, 100, 100)];
    [self.gradualCircleShapeView updateShapeViewStyle:tmpStyle];
    [self.view addSubview:self.gradualCircleShapeView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"更换方向" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
}


#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    self.gradualCircleShapeView.shapeViewStyle.isClockwise = NO;
    self.gradualCircleShapeView.shapeViewStyle.gradientColorArray = @[
                                                                        [UIColor redColor],
                                                                        [UIColor blueColor],
                                                                        [UIColor greenColor],
                                                                        [UIColor yellowColor],
                                                                        [UIColor blackColor],
                                                                        ];
    [self.gradualCircleShapeView updateViewControls];
}

@end
