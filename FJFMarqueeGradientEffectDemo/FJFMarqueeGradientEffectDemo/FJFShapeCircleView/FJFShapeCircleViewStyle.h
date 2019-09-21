//
//  FJFShapeCircleViewStyle.h
//  FJFTestProject
//
//  Created by 方金峰 on 2018/10/17.
//  Copyright © 2018年 方金峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJFShapeCircleViewStyle : NSObject
// circleRadius
@property (nonatomic, assign) CGFloat  circleRadius;
// lineWidth
@property (nonatomic, assign) CGFloat  outterLineWidth;
// outerCircleFillColor
@property (nonatomic, strong) UIColor *outerCircleFillColor;
// outerCircleStrokeColor
@property (nonatomic, strong) UIColor *outerCircleStrokeColor;
// rotateCircleFillColor
@property (nonatomic, strong) UIColor *rotateCircleFillColor;
// rotateCircleStrokeColor
@property (nonatomic, strong) UIColor *rotateCircleStrokeColor;
// gradientLayerColors (CGColor类型)
@property (nonatomic, strong) NSArray *gradientLayerColors;
// gradientLayerLocations
@property (nonatomic, strong) NSArray<NSNumber *> *gradientLayerLocations;
// innerStrokeStart(0-1)
@property (nonatomic, assign) CGFloat  innerStrokeStart;
// innerStrokeEnd (0 - 1)
@property (nonatomic, assign) CGFloat  innerStrokeEnd;
// animationDuration
@property (nonatomic, assign) CGFloat  animationDuration;
// hiddenInnerCircle
@property (nonatomic, assign) BOOL  hiddenInnerCircle;
// innerLineWidth
@property (nonatomic, assign) CGFloat  innerLineWidth;
// innerToOutterSpacing
@property (nonatomic, assign) CGFloat  innerToOutterSpacing;
// innerCircleFillColor
@property (nonatomic, strong) UIColor *innnerCircleFillColor;
// innerCircleStrokeColor
@property (nonatomic, strong) UIColor *innerCircleStrokeColor;

@end
