//
//  FJFAnnulusViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 24/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJAnnulusView.h"
#import "FJFAnnulusViewController.h"
#import "FJFGradualCircleViewController.h"

@interface FJFAnnulusViewController ()
// FJFCurveGraphView
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation FJFAnnulusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    

    FJAnnulusView *tmpView = [[FJAnnulusView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];

    [self.view addSubview:tmpView];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
