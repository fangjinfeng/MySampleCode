//
//  FJFCurveGraphView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFCurveGraphViewStyle : NSObject
// strokeColor
@property (nonatomic, strong) UIColor *strokeColor;
// fillColor
@property (nonatomic, strong) UIColor *fillColor;
// labelTextColor
@property (nonatomic, strong) UIColor *labelTextColor;
// labelTextFont
@property (nonatomic, strong) UIFont *labelTextFont;
// tipCircleViewColor
@property (nonatomic, strong) UIColor *tipCircleViewColor;
// tipCircleViewSize
@property (nonatomic, assign) CGFloat tipCircleViewSize;
// lineWidth(线宽度)
@property (nonatomic, assign) CGFloat  lineWidth;
// singleItemViewValue(每个item视图代表值)
@property (nonatomic, assign) CGFloat  singleItemViewValue;
// singleItemViewHeight(每个item视图高度)
@property (nonatomic, assign) CGFloat  singleItemViewHeight;
// valueTextArray
@property (nonatomic, strong) NSArray <NSString *>*valueTextArray;
@end

@interface FJFCurveGraphView : UIView

// viewStyle
@property (nonatomic, strong, readonly) FJFCurveGraphViewStyle *viewStyle;

/// 更新 子控件
- (void)updateViewControls;

/// 更新 配置 参数
/// @param viewStyle 配置 参数
- (void)updateBackgroundViewStyle:(FJFCurveGraphViewStyle *)viewStyle;

/// 初始化
/// @param frame 位置
/// @param viewStyle 配置参数
- (instancetype)initWithFrame:(CGRect)frame
                    viewStyle:(FJFCurveGraphViewStyle *)viewStyle;


/// 获取 字符串 尺寸
/// @param font 字体
/// @param contentString 字符串 内容
+ (CGSize)sizeForFont:(UIFont *)font contentString:(NSString *)contentString;
@end

NS_ASSUME_NONNULL_END
