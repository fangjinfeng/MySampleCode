//
//  HLLCustomPopMenuTriangleView.m
//  FJFPopMenu
//
//  Created by 方金峰 on 2018/12/21.
//  Copyright © 2018年 方金峰. All rights reserved.
//

#import "FJFCustomPopMenuIndicateView.h"

@interface FJFCustomPopMenuIndicateView()
// triangleShapeLayer 三角型
@property (nonatomic, strong) CAShapeLayer *triangleShapeLayer;
@end

@implementation FJFCustomPopMenuIndicateView
#pragma mark -------------------------- Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViewControls];
        [self updateViewControls];
    }
    return self;
}

#pragma mark -------------------------- Public Methods

- (void)updateViewControls {
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGFloat startPointY = self.frame.size.height;
    CGFloat endPointY = 0;
    // 如果是倒立三角形
    if (_isHeadstandIndicateView) {
        startPointY = 0;
        endPointY = self.frame.size.height;
    }
    [aPath moveToPoint:CGPointMake(0, startPointY)];
    [aPath addLineToPoint:CGPointMake(self.frame.size.width, startPointY)];
    [aPath addLineToPoint:CGPointMake(self.frame.size.width / 2.0f, endPointY)];
    [aPath closePath];
    self.triangleShapeLayer.frame = self.bounds;
    self.triangleShapeLayer.path = aPath.CGPath;
    self.triangleShapeLayer.fillColor = self.fillColor.CGColor;
}

- (void)updateLineWidth:(CGFloat)lineWidth {
     self.triangleShapeLayer.lineWidth = lineWidth;
}

- (void)updateStrokeColor:(UIColor *)strokeColor {
     self.triangleShapeLayer.strokeColor = strokeColor.CGColor;
     self.triangleShapeLayer.strokeStart = [self bottomSideRate];
     self.triangleShapeLayer.strokeEnd = 1;

}
#pragma mark -------------------------- Private Methods

- (void)setupViewControls {
    [self.layer addSublayer:self.triangleShapeLayer];
    self.fillColor = [UIColor whiteColor];
}


// 底边长 比例
- (CGFloat)bottomSideRate {
    CGFloat bottomSideLength = self.frame.size.width;
    CGFloat totalSideLength = [self triangleLengthOfSide];
    return bottomSideLength / totalSideLength;
}

// 三角形 边长
- (CGFloat)triangleLengthOfSide {
    CGFloat bottomSideLength = self.frame.size.width;
    CGFloat halfBottomSideLength = bottomSideLength / 2.0f;
    CGFloat triangleHeight = self.frame.size.height;
    CGFloat sideLength = sqrt(halfBottomSideLength * halfBottomSideLength + triangleHeight * triangleHeight);
    return bottomSideLength + (2 * sideLength);
}

#pragma mark -------------------------- Setter / Getter

- (CAShapeLayer *)triangleShapeLayer {
    if (!_triangleShapeLayer) {
        _triangleShapeLayer = [CAShapeLayer layer];
        _triangleShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _triangleShapeLayer;
}
@end
