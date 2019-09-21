
//
//  FJFMarqueeViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by fjf on 16/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFMarqueeView.h"
#import "FJFMarqueeViewController.h"

@interface FJFMarqueeViewController ()

@end

@implementation FJFMarqueeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    FJFMarqueeView *marqueenView = [[FJFMarqueeView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [self.view addSubview:marqueenView];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
