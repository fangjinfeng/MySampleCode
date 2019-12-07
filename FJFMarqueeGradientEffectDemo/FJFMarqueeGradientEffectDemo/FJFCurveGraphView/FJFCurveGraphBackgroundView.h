//
//  FJFCurveGraphBackgroundView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 控件  属性
@interface FJFCurveGraphBackgroundControlsProperty : NSObject
// verticalFont
@property (nonatomic, strong) UIFont *verticalFont;
// horizontalFont
@property (nonatomic, strong) UIFont *horizontalFont;
// verticalTextColor
@property (nonatomic, strong) UIColor *verticalTextColor;
// horizontalTextColor
@property (nonatomic, strong) UIColor *horizontalTextColor;
// lineViewBackgroundColor
@property (nonatomic, strong) UIColor *lineViewBackgroundColor;
@end

@interface FJFCurveGraphBackgroundViewStyle : NSObject
// lineViewHeight
@property (nonatomic, assign) CGFloat  lineViewHeight;
// leftEdgeSpacing
@property (nonatomic, assign) CGFloat  leftEdgeSpacing;
// rightEdgeSpacing
@property (nonatomic, assign) CGFloat  rightEdgeSpacing;
// verticalLabelWidth
@property (nonatomic, assign) CGFloat  verticalLabelWidth;
// verticalViewSpacing 间距
@property (nonatomic, assign) CGFloat  verticalViewSpacing;
// horizontalLabelWidth
@property (nonatomic, assign) CGFloat  horizontalLabelWidth;
// labelToVerticalLineSpacing 垂直 分割线 和 label 间距
@property (nonatomic, assign) CGFloat  labelToVerticalLineSpacing;
// curveGraphViewTopEdgeSpacing 顶部 间距
@property (nonatomic, assign) CGFloat  curveGraphViewTopEdgeSpacing;
// curveGraphBackgroundViewWidth  宽度
@property (nonatomic, assign) CGFloat  curveGraphBackgroundViewWidth;
// verticalTextArray
@property (nonatomic, strong) NSArray <NSString *> *verticalTextArray;
// horizontalTextArray
@property (nonatomic, strong) NSArray <NSString *> *horizontalTextArray;
// horizontalLabelToCurveGraphViewSpacing 底部 label 间距
@property (nonatomic, assign) CGFloat  horizontalLabelToCurveGraphViewSpacing;
// hideVerticalFirstLabel 隐藏 垂直 第一个 属性
@property (nonatomic, assign, getter=isHideVerticalFirstLabel) BOOL  hideVerticalFirstLabel;
// controlsPropertyStyle 控件 基本 属性
@property (nonatomic, strong) FJFCurveGraphBackgroundControlsProperty *controlsPropertyStyle;
@end


@interface FJFCurveGraphBackgroundView : UIView
// verticalLabelArray
@property (nonatomic, strong, readonly) NSArray <UILabel *> *verticalLabelArray;
// horizontalLabelArray
@property (nonatomic, strong, readonly) NSArray <UILabel *> *horizontalLabelArray;
// curveGraphLineContainerView
@property (nonatomic, strong, readonly) UIView *curveGraphLineContainerView;
// viewStyle
@property (nonatomic, strong, readonly) FJFCurveGraphBackgroundViewStyle *viewStyle;

/// 更新 控件
- (void)updateViewControls;

/// 配置 参数
/// @param backgroundViewStyle 配置 参数
- (void)updateBackgroundViewStyle:(FJFCurveGraphBackgroundViewStyle *)backgroundViewStyle;

/// 初始化
/// @param frame 位置
/// @param viewStyle viewStyle
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFCurveGraphBackgroundViewStyle *)viewStyle;



@end

NS_ASSUME_NONNULL_END
