//
//  FJFIndicatorTriangleBorderView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 08/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFIndicatorTriangleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFIndicatorTriangleBorderViewStyle : NSObject
// contentViewCornerRadius
@property (nonatomic, assign) CGFloat  contentViewCornerRadius;
// contentViewBorderWidth
@property (nonatomic, assign) CGFloat  contentViewBorderWidth;
// contentViewBorderColor
@property (nonatomic, strong) UIColor  *contentViewBorderColor;
// contentViewFillColor 填充色
@property (nonatomic, strong) UIColor  *contentViewFillColor;
// indicatorTriangleViewWidth 箭头 宽度
@property (nonatomic, assign) CGFloat  indicatorTriangleViewWidth;
// indicatorTriangleViewHeight 箭头 高度
@property (nonatomic, assign) CGFloat  indicatorTriangleViewHeight;
// indicatorTriangleViewOffset 箭头 相对于 所在位置 偏移
// 上、下 (偏移量是从左到右算)
// 左、右 (偏移量是从上到下算)
@property (nonatomic, assign) CGFloat  indicatorTriangleViewOffset;
// indicatorTriangleViewType 箭头 方向
@property (nonatomic, assign) FJFIndicatorTriangleViewType  indicatorTriangleViewType;
@end

@interface FJFIndicatorTriangleBorderView : UIView
// contentView
@property (nonatomic, strong, readonly) UIView *contentView;
// viewStyle
@property (nonatomic, strong, readonly) FJFIndicatorTriangleBorderViewStyle *viewStyle;
// indicatorTriangleView
@property (nonatomic, strong, readonly) FJFIndicatorTriangleView *indicatorTriangleView;

// 更新 控件
- (void)updateViewControls;

// 更新 viewStyle
- (void)updateViewStyle:(FJFIndicatorTriangleBorderViewStyle *)viewStyle;

/// 依据 viewStyle 初始化
/// @param frame 位置
/// @param viewStyle 配置参数
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFIndicatorTriangleBorderViewStyle *)viewStyle;
@end

NS_ASSUME_NONNULL_END
