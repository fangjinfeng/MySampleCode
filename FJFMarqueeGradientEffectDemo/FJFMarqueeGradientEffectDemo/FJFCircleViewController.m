//
//  FJFCircleViewController.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by fjf on 16/09/2019.
//  Copyright © 2019 fjf. All rights reserved.
//

#import "FJFShapeCircleView.h"
#import "FJFCircleViewController.h"

// 动画 视图 效果
static const CGFloat kFJFCircleViewSize = 148.0f;

@interface FJFCircleViewController ()
// shapeCircleView
@property (nonatomic, strong) FJFShapeCircleView *shapeCircleView;
@end

@implementation FJFCircleViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.shapeCircleView];
    self.view.backgroundColor = [UIColor colorWithRed:42/255.0f green:44/255.0f blue:56/255.0 alpha:1.0f];;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_shapeCircleView removeAnimation];
}

#pragma mark - Setter Getter
// animationView
- (FJFShapeCircleView *)shapeCircleView {
    if (!_shapeCircleView) {
        _shapeCircleView = [[FJFShapeCircleView alloc] initWithFrame:CGRectMake(0, 0, kFJFCircleViewSize, kFJFCircleViewSize)];
        [_shapeCircleView startAnimation];
        [_shapeCircleView startInnerCircleRotationAnimation];
        _shapeCircleView.center = self.view.center;
    }
    return _shapeCircleView;
}

@end
