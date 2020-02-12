//
//  FJFExpandLabelTool.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 22/01/2020.
//  Copyright © 2020 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FJFExpandLabelShowType) {
    // 正常 显示
    FJFExpandLabelShowTypeNormal = 0,
    // 显示 展开 收起
    FJFExpandLabelShowTypeExpandAndPickup,
    // 只显示 展开(没有收起)
    FJFExpandLabelShowTypeOnlyExpand,
};

@class FJFExpandLabelStyle;

NS_ASSUME_NONNULL_BEGIN

@interface FJFExpandLabelTool : NSObject


/// 依据  labelStyle 生成 富文本
/// @param expandLabelStyle 文本 属性
+ (NSAttributedString *)generateShowContentWithExpandLabelStyle:(FJFExpandLabelStyle *)expandLabelStyle;


/// 获取 指定 行数 字符串
/// @param limitLine 指定 行数
/// @param limitWidth 限制 宽度
/// @param contentFont 文本 字体
/// @param contentText 文本
/// @param trailingBlankWidth 尾部 间距
+ (NSString *)fjf_lineStringWithLimitLine:(NSInteger)limitLine
                               limitWidth:(CGFloat)limitWidth
                              contentFont:(UIFont *)contentFont
                              contentText:(NSString *)contentText
                       trailingBlankWidth:(CGFloat)trailingBlankWidth;


/// 获取 每一行 字符串 数组
/// @param limitWidth 限制 宽度
/// @param contentFont 文本 字体
/// @param contentText 文本 内容
+ (NSArray *)fjf_lineStringArrayWithLimitWidth:(CGFloat)limitWidth
                                   contentFont:(UIFont *)contentFont
                                   contentText:(NSString *)contentText;


/// 获取 最后 一行 字符串
/// @param limitWidth 限制 宽度
/// @param contentFont 字体
/// @param contentText 文本
+ (NSString *)fjf_lastLineStringWithLimitWidth:(CGFloat)limitWidth
                                   contentFont:(UIFont *)contentFont
                                   contentText:(NSString *)contentText;
@end

NS_ASSUME_NONNULL_END
