
//
//  FJFHistogramContainerView.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 09/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFHistogramContainerView.h"

@implementation FJFHistogramContainerView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame histogramViewStyle:[[FJFHistogramViewStyle alloc] init] backgroundViewStyle:[[FJFHistogramBackgroundViewStyle alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame
          histogramViewStyle:(FJFHistogramViewStyle *)histogramViewStyle
          backgroundViewStyle:(FJFHistogramBackgroundViewStyle *)backgroundViewStyle{
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
    self.histogramViewStyle.horizontalTextCount = self.backgroundViewStyle.horizontalTextArray.count;
    [self.histogramView updateViewControls];
}

#pragma mark - Private Methods

- (void)setupViewControls {
    [self addSubview:self.backgroundView];
    [self addSubview:self.histogramView];
}

- (void)layoutViewControls {
    self.backgroundView.frame = self.bounds;
    
    // histogramView
    self.histogramView.frame = self.backgroundView.histogramLineContainerView.frame;
}

#pragma mark - Setter / Getter

- (FJFHistogramViewStyle *)histogramViewStyle {
    return self.histogramView.viewStyle;
}

- (FJFHistogramBackgroundViewStyle *)backgroundViewStyle {
    return self.backgroundView.viewStyle;
}


// histogramView
- (FJFHistogramView *)histogramView {
    if (!_histogramView) {
        _histogramView = [[FJFHistogramView alloc] initWithFrame:self.backgroundView.histogramLineContainerView.frame];
    }
    return _histogramView;
}

// histogramView
- (FJFHistogramBackgroundView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[FJFHistogramBackgroundView alloc] initWithFrame:self.bounds];
    }
    return _backgroundView;
}
@end
