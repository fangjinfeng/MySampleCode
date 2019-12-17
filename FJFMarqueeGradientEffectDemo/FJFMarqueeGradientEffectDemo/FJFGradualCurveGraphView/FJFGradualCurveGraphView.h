//
//  FJFCurveGraphView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFGradualCurveGraphValueModel : NSObject

// verticalContentValue
@property (nonatomic, copy) NSString *verticalContentValue;

// horizontalContentValue
@property (nonatomic, copy) NSString *horizontalContentValue;


/// 配置 valueModel
/// @param verticalContentValue 垂直 文本
/// @param horizontalContentValue 水平 文本
+ (FJFGradualCurveGraphValueModel *)configWithVerticalContentValue:(NSString *)verticalContentValue
                                            horizontalContentValue:(NSString *)horizontalContentValue;

@end

@interface FJFGradualCurveGraphViewStyle : NSObject
// topLayerFillColor
@property (nonatomic, strong) UIColor *topLayerFillColor;
// topLayerStrokeColor
@property (nonatomic, strong) UIColor *topLayerStrokeColor;
// lineWidth(线宽度)
@property (nonatomic, assign) CGFloat  lineWidth;

// bottomLayerFillColor
@property (nonatomic, strong) UIColor *bottomLayerFillColor;
// bottomLayerStrokeColor
@property (nonatomic, strong) UIColor *bottomLayerStrokeColor;


// singleVerticalItemViewValue(每个item视图代表值)
@property (nonatomic, assign) CGFloat  singleVerticalItemViewValue;
// singleVerticalItemViewHeight(每个item视图高度)
@property (nonatomic, assign) CGFloat  singleVerticalItemViewHeight;

// singleHorizontalItemViewValue(每个item视图代表值)
@property (nonatomic, assign) CGFloat  singleHorizontalItemViewValue;
// singleHorizontalItemViewWidth(每个item视图宽度)
@property (nonatomic, assign) CGFloat  singleHorizontalItemViewWidth;

// backgroundViewColor (如果是渐变颜色，不能为clearColor)
@property (nonatomic, strong) UIColor *backgroundViewColor;

// lineCenterViewColor 中心线 背景色
@property (nonatomic, strong) UIColor *lineCenterViewColor;

// lineCenterViewHeight 中心线 高度
@property (nonatomic, assign) CGFloat lineCenterViewHeight;

// valueTextValueModelArray
@property (nonatomic, strong) NSArray <FJFGradualCurveGraphValueModel *>*valueTextValueModelArray;


@end

@interface FJFGradualCurveGraphMaskLineView : UIView
// lineLayer
@property (nonatomic, strong) CAShapeLayer *lineLayer;

// lineMaskLayer
@property (nonatomic, strong) CAShapeLayer *lineMaskLayer;

// lineBackgroundMaskLayer
@property (nonatomic, strong) CAShapeLayer *lineBackgroundMaskLayer;

/// 更新 控件 颜色
/// @param lineViewColor 线条 颜色
/// @param backgroundColor 背景 颜色
- (void)updateLineViewColor:(UIColor *)lineViewColor
            backgroundColor:(UIColor *)backgroundColor;

/// 更新 控件
/// @param isTopView 是否 位于 顶部
/// @param lineWidth 线宽度
/// @param lineLayerFrame 分割线 位置
- (void)updateViewControlsWithIsTopView:(BOOL)isTopView
                              lineWidth:(CGFloat)lineWidth
                         lineLayerFrame:(CGRect)lineLayerFrame;
@end


@interface FJFGradualCurveGraphView : UIView

// viewStyle
@property (nonatomic, strong, readonly) FJFGradualCurveGraphViewStyle *viewStyle;

/// 更新 子控件
- (void)updateViewControls;

/// 更新 配置 参数
/// @param viewStyle 配置 参数
- (void)updateBackgroundViewStyle:(FJFGradualCurveGraphViewStyle *)viewStyle;

/// 初始化
/// @param frame 位置
/// @param viewStyle 配置参数
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFGradualCurveGraphViewStyle *)viewStyle;


/// 获取 字符串 尺寸
/// @param font 字体
/// @param contentString 字符串 内容
+ (CGSize)sizeForFont:(UIFont *)font contentString:(NSString *)contentString;
@end

NS_ASSUME_NONNULL_END
