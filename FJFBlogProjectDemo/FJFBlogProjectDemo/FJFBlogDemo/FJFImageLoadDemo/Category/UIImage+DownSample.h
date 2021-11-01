//
//  UIImage+DownSample.h
//  FJFBlogProjectDemo
//
//  Created by fjf on 2021/9/18.
//  Copyright © 2021 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DownSample)

/// 降低 采样率
/// @param scale 比例
/// @param imgURL 图片 地址
/// @param targetSize 显示 尺寸
+ (UIImage *)downSamplingWithScale:(CGFloat)scale
                            imgUrl:(NSURL *)imgURL
                        targetSize:(CGSize)targetSize;

/// 降低 采样率
/// @param scale 比例
/// @param imgData 图片 数据
/// @param targetSize 显示 尺寸
+ (UIImage *)downSamplingWithScale:(CGFloat)scale
                           imgData:(NSData *)imgData
                        targetSize:(CGSize)targetSize;
// 获取 缩放后的尺寸
+ (CGSize)imageSizeWidthTargetWidth:(CGFloat)targetWidth
                       originalSize:(CGSize)originalSize;
@end

NS_ASSUME_NONNULL_END
