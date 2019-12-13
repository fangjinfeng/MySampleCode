//
//  FJFIndicatorTriangleView.h
//  FJFMarqueeGradientEffect
//
//  Created by macmini on 19/11/2019.
//  Copyright © 2019 FJFMarqueeGradientEffect. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FJFIndicatorTriangleViewType) {
    // 上
    FJFIndicatorTriangleViewTypeTop = 0,
    // 下
    FJFIndicatorTriangleViewTypeBottom,
    // 左
    FJFIndicatorTriangleViewTypeLeft,
    // 右
    FJFIndicatorTriangleViewTypeRight,
};

@interface FJFIndicatorTriangleView : UIView
// fillColor
@property (nonatomic, strong) UIColor *fillColor;

// triangleViewType
@property (nonatomic, assign) FJFIndicatorTriangleViewType  triangleViewType;

// 更新 控件
- (void)updateViewControls;

/// 更新 边框 宽度
/// @param lineWidth 边框 宽度
- (void)updateLineWidth:(CGFloat)lineWidth;

/// 更新 填充色
/// @param fillColor 填充色
- (void)updateFillColor:(UIColor *)fillColor;

/// 更新 边框 颜色
/// @param strokeColor 边框颜色
- (void)updateStrokeColor:(UIColor *)strokeColor;
@end

NS_ASSUME_NONNULL_END
