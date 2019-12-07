
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

@end

#define FJF_HEXColor(rgbValue) \
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@implementation FJFGradualCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FJFGradualCircleShapeViewStyle *tmpStyle = [[FJFGradualCircleShapeViewStyle alloc] init];
    tmpStyle.gradientColorArray = @[ FJF_HEXColor(0xFFA400), FJF_HEXColor(0xFF9000), FJF_HEXColor(0xFF8100), FJF_HEXColor(0xFF6B00), FJF_HEXColor(0xFF5A00),
                                    ];
    
    FJFGradualCircleShapeView *tmpView = [[FJFGradualCircleShapeView alloc] initWithFrame:CGRectMake(150, 200, 100, 100)];
    [tmpView updateShapeViewStyle:tmpStyle];
    [self.view addSubview:tmpView];
    
}



@end
