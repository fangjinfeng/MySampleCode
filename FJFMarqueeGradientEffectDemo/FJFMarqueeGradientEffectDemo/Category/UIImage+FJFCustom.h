//
//  UIImage+FJFCustom.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by FJF on 2019/1/27.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FJFCustom)

typedef NS_ENUM(NSInteger, FJFGradientDirection) {
    FJFGradientDirectionTopToBottom = 0,    // 从上往下 渐变
    FJFGradientDirectionLeftToRight,        // 从左往右
    FJFGradientDirectionBottomToTop,      // 从下往上
    FJFGradientDirectionRightToLeft      // 从右往左
};

#pragma mark 根据颜色获取图片
//+ (UIImage *)imageWithColor:(UIColor *)color;


/// 生产 图片
/// @param color 颜色
/// @param imageSize 尺寸
+ (UIImage *)fjf_imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;

/// 生产 圆形 图片
/// @param color 颜色
/// @param imageSize 尺寸
+ (UIImage *)fjf_circleImageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;
/**
 *  @brief
 *  生成渐变色图片
 *  @param  bounds  图片的大小
 *  @param  colorArray      渐变颜色组
 *  @param  gradientType     渐变方向
 *
 *  @return 图片
 */

/// 生成渐变色图片
+ (UIImage*)fjf_gradientImageWithBounds:(CGRect)bounds
                            colorArray:(NSArray <UIColor *>*)colorArray
                          gradientType:(FJFGradientDirection)gradientType;



/// 生成渐变色图片
+ (UIImage*)fjf_gradientImageWithViewSize:(CGSize)viewSize
                              colorArray:(NSArray <UIColor *>*)colorArray
                            gradientType:(FJFGradientDirection)gradientType;
@end

