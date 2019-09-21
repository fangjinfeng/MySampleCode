//
//  FJShapeCircleView.h
//  FJBezierPathDemo
//
//  Created by fjf on 2017/6/2.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJFShapeCircleViewStyle;

@interface FJFShapeCircleView : UIView

// circleViewStyle
@property (nonatomic, strong, readonly) FJFShapeCircleViewStyle *circleViewStyle;

/**
 初始化 shapeCircleView

 @param frame 位置
 @param circleViewStyle viewStyle
 @return 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame circleViewStyle:(FJFShapeCircleViewStyle *)circleViewStyle;
// 开始 动画 效果
- (void)startAnimation;
// 移除 动画 效果
- (void)removeAnimation;
// 移除 内圆 旋转
- (void)stopInnerCircleRotationAnimation;
// 开始 内圆 旋转
- (void)startInnerCircleRotationAnimation;
@end
