//
//  FJFHistogramContainerView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 09/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import "FJFHistogramView.h"
#import "FJFHistogramBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFHistogramContainerView : UIView
// histogramView
@property (nonatomic, strong) FJFHistogramView *histogramView;
// backgroundView
@property (nonatomic, strong) FJFHistogramBackgroundView *backgroundView;
// histogramViewStyle
@property (nonatomic, strong, readonly) FJFHistogramViewStyle *histogramViewStyle;
// backgroundViewStyle
@property (nonatomic, strong, readonly) FJFHistogramBackgroundViewStyle *backgroundViewStyle;
/// 更新 viewControls
- (void)updateViewControls;
@end

NS_ASSUME_NONNULL_END
