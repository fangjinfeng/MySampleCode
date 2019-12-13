
//
//  FJFIndicatorTriangleBorderViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 08/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFIndicatorTriangleBorderView.h"
#import "FJFIndicatorTriangleBorderViewController.h"

@interface FJFIndicatorTriangleBorderViewController ()
// borderView
@property (nonatomic, strong) FJFIndicatorTriangleBorderView *borderView;
@end

@implementation FJFIndicatorTriangleBorderViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.borderView = [[FJFIndicatorTriangleBorderView alloc] initWithFrame:CGRectMake(100, 150, 150, 100)];
    [self.view addSubview:self.borderView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 120, 60)];
    [tmpButton setTitle:@"更换方向" forState:UIControlStateNormal];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    tmpButton.backgroundColor = [UIColor redColor];
    tmpButton.tag = 0;
    tmpButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:tmpButton];
}

#pragma mark - Response Event
- (void)tmpButtonClicked:(UIButton *)sender {
    sender.tag += 1;
    if (sender.tag > FJFIndicatorTriangleViewTypeRight) {
        sender.tag = 0;
    }
    self.borderView.viewStyle.indicatorTriangleViewType = sender.tag;
    [self.borderView updateViewControls];
}
@end
