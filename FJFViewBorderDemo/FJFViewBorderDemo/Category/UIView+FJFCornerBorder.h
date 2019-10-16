//
//  UIView+FJFCornerBorder.h
//  FJFViewBorderDemoo
//
//  Created by macmini on 16/10/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

// 边框 显示 方向
typedef NS_ENUM(NSUInteger, FJFViewBorderType) {
    FJFViewBorderTypeTop,
    FJFViewBorderTypeBottom,
    FJFViewBorderTypeAll,
};


NS_ASSUME_NONNULL_BEGIN

@interface UIView (FJFCornerBorder)

/// 设置 带圆角的边框
/// @param cornerRadius 圆角值
/// @param borderWidth 边框 宽度
/// @param borderColor 边框 颜色
/// @param viewBorderType 边框 类型 (底部边框、顶部边框，全边框)
- (CAShapeLayer *)fjf_setCornerRadius:(CGFloat)cornerRadius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       viewBorderType:(FJFViewBorderType)viewBorderType;


/// 设置 边框 视图
/// @param cornerRadius 圆角值
/// @param borderView 添加 边框 视图
/// @param borderWidth 边框 宽度
/// @param borderColor 边框 宽度
/// @param viewBorderType 边框 类型 (底部边框、顶部边框，全边框)
+ (CAShapeLayer *)fjf_setCornerRadius:(CGFloat)cornerRadius
                           borderView:(UIView *)borderView
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       viewBorderType:(FJFViewBorderType)viewBorderType;
@end

NS_ASSUME_NONNULL_END
