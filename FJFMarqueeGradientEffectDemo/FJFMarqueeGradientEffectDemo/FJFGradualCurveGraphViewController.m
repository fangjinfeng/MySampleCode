//
//  FJFGradualCurveGraphViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 15/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "UIImage+FJFCustom.h"
#import "FJFGradualCurveGraphContainerView.h"
#import "FJFGradualCurveGraphViewController.h"

//MARK: - color
#define XM_RGBColorAlpha(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define XM_RGBColor(r, g, b)            XM_RGBColorAlpha(r, g, b, 1.0)

@interface FJFGradualCurveGraphViewController ()
// curveGraphView
@property (nonatomic, strong) FJFGradualCurveGraphContainerView *curveGraphView;
@end

@implementation FJFGradualCurveGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.curveGraphView = [[FJFGradualCurveGraphContainerView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 300)];
    
    CGFloat viewHeight = 80.0f;
    UIImage *topImage = [UIImage fjf_gradientImageWithViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, viewHeight) colorArray:@[XM_RGBColorAlpha(255, 65, 0, 0.0), XM_RGBColorAlpha(255, 65, 0, 0.5)] gradientType:XMGradientDirectionTopToBottom];
    self.curveGraphView.curveGraphViewStyle.topLayerFillColor = [UIColor colorWithPatternImage:topImage];
    
    UIImage *bottomImage = [UIImage fjf_gradientImageWithViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, viewHeight) colorArray:@[XM_RGBColorAlpha(60, 127, 255, 0.5), XM_RGBColorAlpha(60, 127, 255, 0.0)] gradientType:XMGradientDirectionTopToBottom];
    self.curveGraphView.curveGraphViewStyle.bottomLayerFillColor = [UIColor colorWithPatternImage:bottomImage];
    [self.curveGraphView updateViewControls];
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
    self.curveGraphView.backgroundViewStyle.verticalTextArray =  @[@"150", @"100", @"50", @"0", @"-50", @"-100", @"-150"];

    NSMutableArray *tmpMarray = [NSMutableArray array];
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"10" horizontalContentValue:@"0"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"150" horizontalContentValue:@"5"];
        [tmpMarray addObject:tmpModel];
    }
    
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"20" horizontalContentValue:@"10"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"15"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-130" horizontalContentValue:@"20"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-50" horizontalContentValue:@"25"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"30"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"30"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-90" horizontalContentValue:@"40"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"45"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"100" horizontalContentValue:@"50"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"60"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"30" horizontalContentValue:@"70"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"80"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
        FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"-30" horizontalContentValue:@"90"];
        [tmpMarray addObject:tmpModel];
    }
    
    {
       FJFGradualCurveGraphValueModel *tmpModel = [FJFGradualCurveGraphValueModel configWithVerticalContentValue:@"0" horizontalContentValue:@"100"];
       [tmpMarray addObject:tmpModel];
    }
    
    self.curveGraphView.curveGraphViewStyle.singleVerticalItemViewValue = 50;
    CGFloat viewHeight = ((self.curveGraphView.backgroundViewStyle.verticalTextArray.count - 1) / 2.0) * self.curveGraphView.curveGraphViewStyle.singleVerticalItemViewValue;
    UIImage *topImage = [UIImage fjf_gradientImageWithViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, viewHeight) colorArray:@[XM_RGBColorAlpha(255, 65, 0, 0.0), XM_RGBColorAlpha(255, 65, 0, 0.5)] gradientType:XMGradientDirectionTopToBottom];
    self.curveGraphView.curveGraphViewStyle.topLayerFillColor = [UIColor colorWithPatternImage:topImage];

    UIImage *bottomImage = [UIImage fjf_gradientImageWithViewSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, viewHeight) colorArray:@[XM_RGBColorAlpha(60, 127, 255, 0.5), XM_RGBColorAlpha(60, 127, 255, 0.0)] gradientType:XMGradientDirectionTopToBottom];
    self.curveGraphView.curveGraphViewStyle.bottomLayerFillColor = [UIColor colorWithPatternImage:bottomImage];
    
    
    self.curveGraphView.curveGraphViewStyle.valueTextValueModelArray = tmpMarray;
    [self.curveGraphView updateViewControls];
}


@end
