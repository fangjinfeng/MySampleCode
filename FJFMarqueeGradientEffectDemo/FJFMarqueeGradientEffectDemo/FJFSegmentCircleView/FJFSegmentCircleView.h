//
//  FJFSegmentCircleView.h
//  FJFMarqueeGradientEffectDemo
//
//  Created by macmini on 03/12/2019.
//  Copyright © 2019 macmini. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FJFSegmentCircleViewStartPositionType) {
    // 从左边 开始
    FJFSegmentCircleViewStartPositionTypeLeft = 0,
    // 从顶部 开始
    FJFSegmentCircleViewStartPositionTypeTop,
    // 从右边 开始
    FJFSegmentCircleViewStartPositionTypeRight,
    // 从底部 开始
    FJFSegmentCircleViewStartPositionTypeBottom,
};

// 圆环 起点 和 终点
@interface FJFSegmentCircleViewStrokeModel : NSObject
// strokeStart
@property (nonatomic, assign) CGFloat  strokeStart;
// strokeEnd
@property (nonatomic, assign) CGFloat  strokeEnd;

/// FJFSegmentCircleViewStrokeModel
/// @param strokeStart 起点
/// @param strokeEnd 终点
+ (FJFSegmentCircleViewStrokeModel *)configWithStrokeStart:(CGFloat)strokeStart
                                                 strokeEnd:(CGFloat)strokeEnd;
@end

@interface FJFSegmentCircleViewStyle : NSObject
// lineWidth
@property (nonatomic, assign) CGFloat  lineWidth;
// isClockwise (是否顺时针)
@property (nonatomic, assign) BOOL  isClockwise;
// strokeColorArray
@property (nonatomic, strong) NSArray <UIColor *>*strokeColorArray;
// startPositionType
@property (nonatomic, assign) FJFSegmentCircleViewStartPositionType startPositionType;
// strokePositionModelArray
@property (nonatomic, strong) NSArray <FJFSegmentCircleViewStrokeModel *> *strokePositionModelArray;
@end


@interface FJFSegmentCircleView : UIView

// shapeLayerArray
@property (nonatomic, strong, readonly) NSArray <CAShapeLayer *>*shapeLayerArray;

// segmentCircleViewStyle
@property (nonatomic, strong, readonly) FJFSegmentCircleViewStyle *segmentCircleViewStyle;
/// 更新 viewController
- (void)updateViewControls;

/// 更新 配置 参数
/// @param segmentCircleViewStyle 配置 参数
- (void)updateSegmentCircleViewStyle:(FJFSegmentCircleViewStyle *)segmentCircleViewStyle;

/// 初始化
/// @param frame 位置
/// @param segmentCircleViewStyle 配置参数
- (instancetype)initWithFrame:(CGRect)frame
       segmentCircleViewStyle:(FJFSegmentCircleViewStyle *)segmentCircleViewStyle;
@end

NS_ASSUME_NONNULL_END
