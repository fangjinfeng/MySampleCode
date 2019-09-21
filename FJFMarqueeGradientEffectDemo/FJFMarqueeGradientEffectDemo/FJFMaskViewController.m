//
//  FJFMastViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by fjf on 09/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFMarqueeView.h"
#import "FJFMaskViewController.h"

@interface FJFMaskViewController ()
// testView
@property (nonatomic, strong) UIView *testView;

// testLayer
@property (nonatomic, strong) CAShapeLayer *testLayer;

// colorSlide
@property (nonatomic, strong) UISlider *colorSlider;
@end

@implementation FJFMaskViewController

#pragma mark -------------------------- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.testView];
    [self.view addSubview:self.colorSlider];
    self.testView.layer.mask = self.testLayer;
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark -------------------------- Response Event
- (void)colorSliderValueChange:(UISlider *)slider {
    CGFloat colorAlpahValue = slider.value;
    CGRect tmpFrame = _testLayer.frame;
    tmpFrame.size.width = 120 * colorAlpahValue;
    _testLayer.frame = tmpFrame;
    _testLayer.backgroundColor = kColorFromRGBA(0X000000, colorAlpahValue).CGColor;
}

#pragma mark -------------------------- Setter / Getter
// _testView
- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 120, 80)];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

// _testLayer
- (CAShapeLayer *)testLayer {
    if (!_testLayer) {
        _testLayer = [CAShapeLayer layer];
        _testLayer.frame = CGRectMake(0, 20, 40, 40);
        //创建一个路径
        _testLayer.backgroundColor = kColorFromRGBA(0XFFFFFF, 1).CGColor;
    }
    return _testLayer;
}

// colorSlider
- (UISlider *)colorSlider {
    if (!_colorSlider) {
        _colorSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, 400, 160, 20)];
        _colorSlider.minimumValue = 0.0;
        _colorSlider.maximumValue = 1.0f;
        _colorSlider.value = 0.5;
        [_colorSlider addTarget:self action:@selector(colorSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _colorSlider;
}
@end
