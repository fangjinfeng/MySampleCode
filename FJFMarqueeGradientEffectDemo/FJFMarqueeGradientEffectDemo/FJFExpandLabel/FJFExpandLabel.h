//
//  FJFExpandLabel.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 22/01/2020.
//  Copyright © 2020 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFExpandLabelTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface FJFLabelAttributeStyle : NSObject
// labelFont 字体
@property (nonatomic, strong) UIFont *labelFont;
// labelText 文本 颜色
@property (nonatomic, copy) NSString *labelText;
// labelTextColor 字体 颜色
@property (nonatomic, strong) UIColor *labelTextColor;

/// 配置 style
/// @param labelFont 字体
/// @param labelText 文本
/// @param labelTextColor 文本 颜色
+ (FJFLabelAttributeStyle *)configWithLabelFont:(UIFont *)labelFont
                                      labelText:(NSString *)labelText
                                 labelTextColor:(UIColor *)labelTextColor ;
@end


@interface FJFExpandLabelStyle : NSObject
// limitWidth 限制 宽度
@property (nonatomic, assign) CGFloat limitWidth;
// compareLineNum 比较行数
@property (nonatomic, assign) NSInteger compareLineNum;
// assignLineNum 指定截取行数
@property (nonatomic, assign) NSInteger assignLineNum;
// expandLabelWidth label 宽度
@property (nonatomic, assign) CGFloat expandLabelWidth;
// expandLabelHeight label 高度
@property (nonatomic, assign) CGFloat expandLabelHeight;
// labelShowType 显示 类型
@property (nonatomic, assign) FJFExpandLabelShowType labelShowType;
// contentLabelStyle 文本 内容 属性
@property (nonatomic, strong) FJFLabelAttributeStyle *contentLabelStyle;
// expandLabelStyle 展开 内容 属性
@property (nonatomic, strong) FJFLabelAttributeStyle *expandLabelStyle;
// pickupLabelStyle 收起 内容 属性
@property (nonatomic, strong) FJFLabelAttributeStyle *pickupLabelStyle;
// suffixLabelStyle 后缀(...) 内容 属性
@property (nonatomic, strong) FJFLabelAttributeStyle *suffixLabelStyle;

// assignLineWidth 指定行 字符串 宽度
@property (nonatomic, assign, readonly) CGFloat assignLineWidth;
// assignLineHeight 指定行 字符串 高度
@property (nonatomic, assign, readonly) CGFloat assignLineHeight;
// beyondLimit 是否 超过 限制
@property (nonatomic, assign, getter=isBeyondLimit, readonly) BOOL beyondLimit;
// expandStatus 展开状态 展开/收起 （默认收起状态）
@property (nonatomic, assign, getter=isExpandStatus, readonly) BOOL expandStatus;

/// 更新 是否 超出 限制
/// @param beyondLimit 超出 限制
- (void)updateIsBeyondLimit:(BOOL)beyondLimit;


/// 更新 展开 类型
/// @param expandStatus 展开 类型
- (void)updateExpandStatus:(BOOL)expandStatus;

/// 更新 指定 行数 字符串 宽度
/// @param assignLineWidth  指定 行数 字符串 宽度
- (void)updateAssignLineWidth:(CGFloat)assignLineWidth;

/// 更新 指定 行数 高度
/// @param assignLineHeight 字符串 高度
- (void)updateAssignLineHeight:(CGFloat)assignLineHeight;
@end

@interface FJFExpandLabel : UILabel

/// expandLabelTapBlock
@property (nonatomic, copy) void (^expandLabelTapBlock)(BOOL isExpand);
/// 更新 label
/// @param expandLabelStyle 展开 样式
- (void)updateLabelWithExpandLabelStyle:(FJFExpandLabelStyle *)expandLabelStyle;
@end

NS_ASSUME_NONNULL_END
