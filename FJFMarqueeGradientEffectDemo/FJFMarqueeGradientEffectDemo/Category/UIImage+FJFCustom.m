//
//  UIImage+FJFCustom.m
//  FJFMarqueeGradientEffectDemo
//
//  Created by FJF on 2019/1/27.
//  Copyright © 2019 FJFMarqueeGradientEffectDemo. All rights reserved.
//

#import "UIImage+FJFCustom.h"

@implementation UIImage (FJFCustom)

#pragma mark 根据颜色获取图片
//+ (UIImage *)imageWithColor:(UIColor *)color
//{
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}

+ (UIImage *)fjf_imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize {
    if (color == nil) {
        return nil;
    }
    CGRect rect=CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)fjf_circleImageWithColor:(UIColor *)color imageSize:(CGSize)imageSize {
    if (color == nil) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:rect.size];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddPath(context, maskPath.CGPath);
     CGContextFillPath(context);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/// 生成渐变色图片
+ (UIImage*)fjf_gradientImageWithBounds:(CGRect)bounds
                            colorArray:(NSArray <UIColor *>*)colorArray
                          gradientType:(FJFGradientDirection)gradientType {
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colorArray) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colorArray lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint startPt =  CGPointMake(0.0, 0.0);
    CGPoint endPt =  CGPointMake(0.0, 0.0);
    
    switch (gradientType) {
        case FJFGradientDirectionTopToBottom:
            startPt= CGPointMake(0.0, 0.0);
            endPt= CGPointMake(0.0, bounds.size.height);
            break;
        case FJFGradientDirectionLeftToRight:
            startPt = CGPointMake(0.0, 0.0);
            endPt = CGPointMake(bounds.size.width, 0.0);
            break;
        case FJFGradientDirectionBottomToTop:
            startPt = CGPointMake(0.0, bounds.size.height);
            endPt = CGPointMake(0.0, 0.0);
            break;
        case FJFGradientDirectionRightToLeft:
            startPt = CGPointMake(bounds.size.width, 0.0);
            endPt = CGPointMake(0, 0.0);
            break;
    }
    CGContextDrawLinearGradient(context, gradient, startPt, endPt, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


/// 生成渐变色图片
+ (UIImage*)fjf_gradientImageWithViewSize:(CGSize)viewSize
                              colorArray:(NSArray <UIColor *>*)colorArray
                            gradientType:(FJFGradientDirection)gradientType {
    NSMutableArray *cgColorMarray = [NSMutableArray array];
    
    for(UIColor *color in colorArray) {
        [cgColorMarray addObject:(__bridge id)color.CGColor];
    }
    CGPoint startPt =  CGPointMake(0.0, 0.0);
    CGPoint endPt =  CGPointMake(0.0, 0.0);
    
    switch (gradientType) {
        case FJFGradientDirectionTopToBottom:
            startPt= CGPointMake(0.0, 0.0);
            endPt= CGPointMake(0.0, 1.0f);
            break;
        case FJFGradientDirectionLeftToRight:
            startPt = CGPointMake(0.0, 0.0);
            endPt = CGPointMake(1.0, 0.0);
            break;
        case FJFGradientDirectionBottomToTop:
            startPt = CGPointMake(0.0, 1.0);
            endPt = CGPointMake(0.0, 0.0);
            break;
        case FJFGradientDirectionRightToLeft:
            startPt = CGPointMake(1.0f, 0.0);
            endPt = CGPointMake(0, 0.0);
            break;
    }
    
    // 渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    // ColorRef 通过bridge id 转化
    gradientLayer.colors = cgColorMarray;
    // 开始点
    gradientLayer.startPoint = startPt;
    // 结束点
    gradientLayer.endPoint = endPt;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(viewSize.width, viewSize.height), NO, 0.0);//原图
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}
@end
