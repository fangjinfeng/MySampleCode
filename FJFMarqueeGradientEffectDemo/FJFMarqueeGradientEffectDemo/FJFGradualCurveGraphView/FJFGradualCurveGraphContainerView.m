//
//  FJFGradualCurveGraphContainerView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 04/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

// view
#import "FJFGradualCurveGraphContainerView.h"

@implementation FJFGradualCurveGraphContainerView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame curveGraphViewStyle:[[FJFGradualCurveGraphViewStyle alloc] init] backgroundViewStyle:[[FJFGradualCurveGraphBackgroundViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
          curveGraphViewStyle:(FJFGradualCurveGraphViewStyle *)curveGraphViewStyle
          backgroundViewStyle:(FJFGradualCurveGraphBackgroundViewStyle *)backgroundViewStyle{
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self layoutViewControls];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateViewControls {
    [self.backgroundView updateViewControls];
    [self layoutViewControls];
    [self.curveGraphView updateViewControls];
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.backgroundView];
    [self addSubview:self.curveGraphView];
}

- (void)layoutViewControls {
    self.backgroundView.frame = self.bounds;
    
    // curveGraphView
    self.curveGraphView.frame = self.backgroundView.curveGraphLineContainerView.frame;
    self.curveGraphViewStyle.lineCenterViewHeight = self.backgroundViewStyle.lineViewHeight;
    self.curveGraphViewStyle.lineCenterViewColor = self.backgroundViewStyle.controlsPropertyStyle.lineViewBackgroundColor;
    self.curveGraphViewStyle.singleHorizontalItemViewWidth = [self.backgroundView horizontalLabelWidth];
}

#pragma mark - Setter / Getter

- (FJFGradualCurveGraphViewStyle *)curveGraphViewStyle {
    return self.curveGraphView.viewStyle;
}

- (FJFGradualCurveGraphBackgroundViewStyle *)backgroundViewStyle {
    return self.backgroundView.viewStyle;
}


// curveGraphView
- (FJFGradualCurveGraphView *)curveGraphView {
    if (!_curveGraphView) {
        _curveGraphView = [[FJFGradualCurveGraphView alloc] initWithFrame:self.backgroundView.curveGraphLineContainerView.frame];
    }
    return _curveGraphView;
}

// curveGraphView
- (FJFGradualCurveGraphBackgroundView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[FJFGradualCurveGraphBackgroundView alloc] initWithFrame:self.bounds];
    }
    return _backgroundView;
}
@end
