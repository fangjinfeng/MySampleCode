//
//  FJFCurveGraphContainerView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 04/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//


#import "FJFCurveGraphView.h"
#import "FJFCurveGraphBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFCurveGraphContainerView : UIView

// curveGraphView
@property (nonatomic, strong) FJFCurveGraphView *curveGraphView;
// backgroundView
@property (nonatomic, strong) FJFCurveGraphBackgroundView *backgroundView;

/// 更新 viewControls
- (void)updateViewControls;
@end

NS_ASSUME_NONNULL_END
