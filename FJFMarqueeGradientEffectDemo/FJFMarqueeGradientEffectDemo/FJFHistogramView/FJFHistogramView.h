//
//  FJFHistogramView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 09/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFHistogramViewStyle : NSObject
// topHistogramColor 上半部分颜色
@property (nonatomic, strong) UIColor *topHistogramColor;
// bottomHistogramColor (下半部分颜色)
@property (nonatomic, strong) UIColor *bottomHistogramColor;
// defalutHistogramWidth (默认宽度)
@property (nonatomic, assign) CGFloat  defalutHistogramWidth;
// singleItemViewValue(每个item视图代表值)
@property (nonatomic, assign) CGFloat  singleItemViewValue;
// singleItemViewHeight(每个item视图高度)
@property (nonatomic, assign) CGFloat  singleItemViewHeight;
// horizontalTextCount
@property (nonatomic, assign) NSInteger  horizontalTextCount;
// valueTextArray
@property (nonatomic, strong) NSArray <NSArray<NSString *> *> *valueTextArray;
// allowBeyondLimitHeight 是否允许 超过 限制 高度
@property (nonatomic, assign, getter=isAllowBeyondLimitHeight) BOOL  allowBeyondLimitHeight;
@end


@interface FJFHistogramView : UIView
// viewStyle
@property (nonatomic, strong, readonly) FJFHistogramViewStyle *viewStyle;
/// 更新 子控件
- (void)updateViewControls;

/// 更新 配置 参数
/// @param viewStyle 配置 参数
- (void)updateBackgroundViewStyle:(FJFHistogramViewStyle *)viewStyle;

/// 初始化
/// @param frame 位置
/// @param viewStyle 配置参数
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFHistogramViewStyle *)viewStyle;
@end

NS_ASSUME_NONNULL_END
