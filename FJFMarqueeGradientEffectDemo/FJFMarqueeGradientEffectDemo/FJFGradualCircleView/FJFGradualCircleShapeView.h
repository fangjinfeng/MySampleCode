//
//  ShapeView.h
//  router
//
//  Created by macmini on 22/09/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJFGradualCircleShapeViewStyle : NSObject
// lineWidth
@property (nonatomic, assign) CGFloat  lineWidth;
// isClockwise (是否顺时针)
@property (nonatomic, assign) BOOL  isClockwise;
// gradientColorArray
@property (nonatomic, strong) NSArray <UIColor *>*gradientColorArray;
@end

@interface FJFGradualCircleShapeView : UIView

// shapeViewStyle
@property (nonatomic, strong, readonly) FJFGradualCircleShapeViewStyle *shapeViewStyle;

/// 更新 viewControls
- (void)updateViewControls;
/// 更新 配置 参数
/// @param shapeViewStyle 配置 参数
- (void)updateShapeViewStyle:(FJFGradualCircleShapeViewStyle *)shapeViewStyle;
/// 依据 配置 参数 进行 初始化
/// @param frame 位置
/// @param shapeViewStyle 参数
- (instancetype)initWithFrame:(CGRect)frame
               shapeViewStyle:(FJFGradualCircleShapeViewStyle *)shapeViewStyle;
@end

NS_ASSUME_NONNULL_END
