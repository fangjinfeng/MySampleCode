//
//  FJFGradualCurveGraphContainerView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 04/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//


#import "FJFGradualCurveGraphView.h"
#import "FJFGradualCurveGraphBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFGradualCurveGraphContainerView : UIView

// curveGraphView
@property (nonatomic, strong) FJFGradualCurveGraphView *curveGraphView;
// backgroundView
@property (nonatomic, strong) FJFGradualCurveGraphBackgroundView *backgroundView;
// curveGraphViewStyle
@property (nonatomic, strong, readonly) FJFGradualCurveGraphViewStyle *curveGraphViewStyle;
// backgroundViewStyle
@property (nonatomic, strong, readonly) FJFGradualCurveGraphBackgroundViewStyle *backgroundViewStyle;
/// 更新 viewControls
- (void)updateViewControls;
@end

NS_ASSUME_NONNULL_END
